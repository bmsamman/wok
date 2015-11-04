require 'trollop'
module Wok
  module WokHelpers

    def build_thor_commands name
      klass = ( "Wok::" + name.classify ).constantize
      directory_location = name.pluralize

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

        puts '-' * 50
        puts directory_location.titleize
        puts '-' * 50

        included_files = "#{File.dirname( __FILE__ )}/#{directory_location}/**"
        user_files =  "./#{directory_location}/**"
        paths = Dir[included_files, user_files ].uniq

        paths.each do |file_path|
          puts File.basename(file_path)
        end

        puts "No #{ directory_location } found" if paths.empty?
      end
    end

  end
end

