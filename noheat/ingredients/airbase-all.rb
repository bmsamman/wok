add_spices do
  opt :dry_run, "Don't actually do anything, just print steps", :short => '-d'
  opt :log_dir, "Output logs to this directory", :short => '-l', :type => :string, :default => ~.wok/reports/
  opt :essid, "ESSID to broadcase", :short => '-e', :type => :string, :default => FreeWifi
  opt :moniface, "Monitor interface", :short => '-m', :type => :string
  opt :gateway_ip, "Gateway IP", :short => '-g', :type => :string
  opt :respond_to_all, "Respond to all beacons", :short => '-b'
  opt :kill_all, "Kill all processes", :short => '-k'
  opt :run, "Run with defaults", :short => '-r'
end

requirements do
  puts "Checking Requirements for airbase-all"
  req  :moniface #check for mon0
end

cook do
  puts "Cooking airbase-all"
  System "airbase-ng -P -C 30  --essid #{options[:essid] -F rogueap -v  #{options[:moniface]  > #{options[:log_dirairbase$(date +%F-%H%M).log] &"
end

cleanup do
  puts "Cleaning up after airbase-all"
  kill "airbase-ng"
end
