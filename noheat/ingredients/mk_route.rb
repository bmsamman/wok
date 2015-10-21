add_spices do
  opt :dry_run, "Don't actually do anything, just print steps", :short => '-d'
  opt :gw_ip, "Gateway IP", :short => '-g', :type => :string
  opt :gw_subnet "Gateway subnet", :short => '-s', :type => :string
  opt :kill_all, "Kill all processes", :short => '-k'
  opt :run, "Run with defaults", :short => '-r'
end

requirements do
  puts "Checking Requirements for mk_route"
  req  :moniface #check for mon0
end

cook do
  puts "Cooking mk_route"
  System "route add -net #{options[:gw_subnet]  gw #{options[:gw_ip]"
end

cleanup do
  puts "Cleaning up after mk_route"
  System "route del -net #{options[:gw_subnet] gw #{options[:gw_ip]"
end
