add_spices do
  opt :iface, "Interface to set into monitor mode", :short => '-i', :type => :string
  opt :channel, "sets the channel of the interface", :short => '-c', :type => :int
end

requirements do
  check_bin "airmon-ng"
  unless @spices[:iface]
    raise "Airmon requires interface.  Ex: wlan0"
  end    
end

cook do
  command_options = ""
  command_options << "#{@spices[:iface]} "
  command_options << "#{@spices[:channel]} "
  cmd "airmon-ng #{command_options} &"
end

cleanup do
  kill "airmon-ng"
end