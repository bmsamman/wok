add_spices do
  opt :dry_run, "Don't actually do anything, just print steps", :short => "-d"
  opt :log_dir, "Output logs to this directory", :short => '-l', :type => :string
  opt :iface, "Interface to internet.", :short => '-i', :type => :string
end

requirements do
  puts "Checking Requirements for recipe1"
end

cook do
  puts "Cooking recipe1"
end

cleanup do
  puts "Cleaning up after recipe1"
end