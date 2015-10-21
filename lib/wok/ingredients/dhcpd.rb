add_spices do
  opt :iface, "interface for DHCP Server", :short => '-i', :type => :string
  opt :foreground, "foreground the dhcp server process", :short => '-f'
  opt :config_file, "location of dhcpd.conf file", :short => '-c', :type => :string
  opt :port, "port to list on", :short => '-p', :type => :int

  opt :gateway_ip, "The ip of the gateway.", :short => '-g', :type => :string
end

requirements do
  check_bin "dhcpd3"
  raise "dhcpd3 requires interface.  Ex: at0" unless @spices[:iface]
  if !@spices[:gateway_ip] and !@spices[:config_file]
    raise "dhcpd3 requires gateway ip.  Ex: 192.168.1.1"
  end
end

cook do
  require 'tmpdir'
  command_options = ""
  command_options << "-f } " if @spices[:foreground]
  command_options << "-p #{@spices[:port] } " if @spices[:port]
  if @spices[:config_file]
    command_options << "-cf #{@spices[:config_file] } "
  else
    conf_file = File.expand_path("#{Dir.tmpdir}/wok_dhcp.conf")
    gateway_substr = @spices[:gateway_ip][/(\d+.){3}/]
    seed = @spices[:gateway_ip].split(".").last.to_i > 150 ? 0 : 150
    start_range =  gateway_substr + "#{seed}"
    end_range =  gateway_substr + "#{seed + 100}"
    subnet = gateway_substr + "0"
    File.open(conf_file, "w+") do |f|
        f.puts "default-lease-time 600;"
        f.puts "max-lease-time 720;"
        f.puts "ddns-update-style none;"
        f.puts "authoritative;"
        f.puts "log-facility local7;"
        f.puts "subnet #{subnet} netmask 255.255.255.0 {"
        f.puts "range #{start_range} #{end_range};"
        f.puts "option routers #{@spices[:gateway_ip]};"
        f.puts "option domain-name-servers #{@spices[:gateway_ip]};"
        f.puts "}"
    end
    command_options << "-cf #{ conf_file } "
  end
  
  command_options << "#{ @spices[:iface] }"

  cmd "dhcpd3 #{command_options}"
end

cleanup do
  kill "dhcpd3"
  conf_file = File.expand_path("#{Dir.tmpdir}/wok_dhcp.conf")
  cmd("rm #{conf_file}") if File.file?(conf_file) and !@spices[:config_file]
end