add_spices do
  opt :dry_run, "Don't actually do anything, just print steps", :short => "-d"
  opt :log_dir, "Output logs to this directory", :short => '-l', :type => :string
  opt :iface, "Interface to internet.", :short => '-i', :type => :string
end

requirements do
  puts "Checking Requirements for Ingredient1"
end

cook do
  puts "Cooking Ingredient1"
  puts @spices[:iface]
end

cleanup do
  puts "Cleaning up after Ingredient1"
end