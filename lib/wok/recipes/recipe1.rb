add_spices do
  opt :dry_run, "Don't actually do anything, just print steps", :short => "-d"
  opt :log_dir, "Output logs to this directory", :short => '-l', :type => :string
  opt :iface, "Interface to internet.", :short => '-i', :type => :string
  opt :wiface, "Interface to wireless network.", :short => '-w', :type => :string, :default => "This is truly special"
  opt :essid, "ESSID to broadcase", :short => '-e', :type => :string
  opt :gateway_ip, "Gateway IP", :short => '-g', :type => :string
  opt :respond_to_all, "Respond to all beacons", :short => '-b'
  opt :kill_all, "Kill all processes", :short => '-k'
  opt :run, "Run with defaults", :short => '-r'
  opt :interactive, "Run in interactive mode", :short => '-a'
end

requirements do
  puts "Checking Requirements for recipe1"
  echo "hello"
end

cook do
  puts "Cooking recipe1 " + spices[:wiface]
  add_ingredient "ingredient1", :iface => "my iface"
  add_recipe "recipe2", :iface => "my iface"
end

cleanup do
  clean_ingredient "ingredient1"
  clean_recipe "recipe2"
  puts "Cleaning up after recipe1"
end
