add_spices do
  opt :dry_run, "Don't actually do anything, just print steps", :short => '-d'
  opt :filename, "A filename", :short => '-f', :default => 'report$(date +%F-%H%M).tar.gz'
  opt :targetdir , "Target directory", :short => '-D', :default => '~/.wok/reports/'
  opt :run, "Run with defaults", :short => '-r'
end

requirements do
  puts "Checking Requirements for gpg_encrypt"
end

cook do
  puts "Cooking gpg_encrypt"
  System "tar -pczf #{options[:filename] #{options[:targerdir]"
  System "gpg -c #{options[:filename]"
end

cleanup do
  puts "Cleaning up after gpg_encrypt"
end
