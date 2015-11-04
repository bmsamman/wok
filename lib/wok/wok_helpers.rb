require 'trollop'
module Wok
  module WokHelpers

    def build_thor_commands name
      klass = ( "Wok::" + name.classify ).constantize
      directory_location = name.pluralize
      namespace name


      %w[requirements cook cleanup taste].each do |stage|
        desc "#{stage} <#{name}_path> [options]", "Execute the #{stage} stage for thise #{name}"
        define_method stage do |file|
          klass.new( file ).send( "execute_#{stage}" )
        end
      end

      desc 'explain [file]', name + ' show options'
      define_method :explain do |file|
        ARGV.shift 4
        klass.new( file ).help
      end


      desc "list [partial file name]", "Lists avaialable #{ directory_location }"
      define_method :list do |limit=""|

        puts "-" * 50 + "\n#{ directory_location.titleize }:\n" + "-" * 50

        paths = Dir["#{File.dirname( __FILE__ )}/#{directory_location}/**", "./#{directory_location}/**" ]
        paths.reject! do |file_path|
          file_path = File.basename(file_path)
          puts paths.map{|path| File.basename(path)}.join("\n\t")
          !file_path.downcase.include?( limit.downcase )
        end

        puts "No #{ directory_location } found" if paths.empty?

      end
    end

  end
end

