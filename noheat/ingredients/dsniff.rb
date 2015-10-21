add_spices do
  opt :dry_run, "Don't actually do anything, just print steps", :short => '-d'
  opt :log_dir, "Output logs to this directory", :short => '-l', :type => :string
  opt :targetiface, "Target interface", :short => '-i', :type => :string
  opt :kill_all, "Kill all processes", :short => '-k'
  opt :run, "Run with defaults", :short => '-r'
end

requirements do
  puts "Checking Requirements for dsniff"
  req  :targetiface
end

cook do
  puts "Cooking dsniff"
  System "dsniff -m -i :targetiface -d -w dsniff$(date +%F-%H%M).log &"
end

cleanup do
  puts "Cleaning up after dsniff"
  kill "dsniff"
end
