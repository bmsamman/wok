add_spices do
  opt :dry_run, "Don't actually do anything, just print steps", :short => "-d"
  opt :log_dir, "Output logs to this directory", :short => '-l', :type => :string
  opt :wiface, "Wireless inteface", :short => '-w', :type => :string
  opt :kill_all, "Kill all processes", :short => '-k'
  opt :run, "Run with defaults", :short => '-r'
  opt :chan, "Wireless channel", :short => '-c', type => :integer, :default => 6
end

requirements do
  puts "Checking Requirements for airmon-ng"
  req  :moniface #check for mon0
end

cook do
  puts "Cooking airmon-ng"
  System "ifconfig #{options[:wiface] down"
  System "airmon-ng start #{options[:wiface]"
  System "ifconfig #{options[:wiface] up"
  System "iwconfig #{options[:wiface]} #{options[:chan]" 
end

cleanup do
  puts "Cleaning up after airmon-ng"
  System "airmon-ng stop :moniface"
end
