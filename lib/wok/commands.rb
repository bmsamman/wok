module Wok
  module Commands
    paths = Dir[ "#{ File.dirname(__FILE__) }/commands/**", './commands/**']
    method_hash = Hash.new

    paths.each do |file|
      m = Module.new

      m.module_eval do
        file_content = File.read( File.expand_path( file ) )
        eval( file_content )
      end

      m.instance_methods.each do |method|
        if method_hash[method]
          raise "The method #{method} in file #{file} has already been defined in file #{method_hash[method]}"
        else
          method_hash[method] = file
        end
      end

      include m
    end
  end
end
