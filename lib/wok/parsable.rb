require 'trollop'
module Wok
  class Parsable
    attr_reader :spices

    def initialize type, name
      @type = type
      @name = name
      @name += '.rb' unless @name.end_with?( '.rb' )
      @stages = Hash.new

      instance_eval content
    end

    %w[requirements cook cleanup].each do |stage|

      define_method(stage) do |&block|
        @stages[stage] = block
      end

      define_method("execute_#{stage}") do
        execute_requirements unless stage == 'requirements'
        @stages[stage].call
      end

    end

    def execute_taste
      $dry = true
      execute_cook
      execute_cleanup
    end

    def add_spices(&block)
      @stages['spices'] = Trollop::Parser.new(&block)
      @spices = @stages['spices'].parse
    end

    def add_ingredient *args
      execute Ingredient, :execute_cook, *args
    end

    def clean_ingredient *args
      execute Ingredient, :execute_cleanup, *args
    end

    def help
      @stages['spices'].educate
    end

    protected

    def content
      content = content_of_files.join("/n")
      return content unless content.empty?
      raise 'Could not find content in any of the expected directories.'
    end

    def content_of_files
      file_paths.map do |file|
        File.read(file)
      end
    end

    def file_path
       @file_path ||= if File.file?( @name )
                        @name
                      else
                        File.join( @type, @name )
                      end
    end

    def file_paths
      local_path = File.join( File.dirname(__FILE__), file_path )
      glob_paths = [File.expand_path( local_path ), File.join('.', file_path)]
      Dir[*glob_paths]
    end

    def execute type, method, path, opts={}
      item = type.new path
      item.spices.merge! opts
      item.send method
    end
  end
end