add_spices do
  opt :dry_run, "Don't actually do anything, just print steps", :short => '-d'
  opt :filename, "A filename", :short => '-f', :default => 'report$(date +%F-%H%M).tar.gz'
  opt :run, "Run with defaults", :short => '-r'
end

requirements do
  puts "Checking Requirements for gpg_decrypt"
end

cook do
  puts "Cooking gpg_decrypt"
  System "gpg #{options[:filename]"
end

cleanup do
  puts "Cleaning up after gpg_decrypt"
end
