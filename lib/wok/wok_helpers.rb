require 'trollop'
module Wok
  module WokHelpers

    class << self
      def included(base) #:nodoc:
        base.send :extend,  ClassMethods
        base.send :build_thor_tasks
      end
    end

    module ClassMethods
      def build_thor_tasks
        namespace Thor::Util.namespace_from_thor_class(parsable_class_name)
        build_stages_tasks parsable_class
        build_help_task parsable_class
        build_list_task
      end

      def parsable_class_name
        @parsable_class_name ||= self.to_s.chomp('Parser')
      end

      def parsable_class
        @parsable_class ||= parsable_class_name.constantize
      end

      def parsable_type
        @parsable_type ||= self.to_s[/Wok::(.*)Parser/,1]
      end

      def build_stages_tasks klass
        %w[requirements cook cleanup taste].each do |stage|
          usage = "#{stage} <#{parsable_type}_path> [options]"
          description = "Execute the #{stage} stage for thise #{parsable_type}"
          desc usage, description
          define_method stage do |file|
            klass.new( file ).send( "execute_#{stage}" )
          end
        end
      end

      def build_list_task
        directory_location = parsable_type.pluralize
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

      def build_help_task klass
        desc 'explain [file]', parsable_type + ' show options'
        define_method :explain do |file|
          ARGV.shift 4
          klass.new( file ).help
        end
      end
    end

    end
end

