require 'trollop'
module Wok
  class Parsable
    attr_reader :spices
    
    def initialize type, name
      path = name.end_with?( ".rb" ) ? name : name + ".rb"
      path = File.file?( path ) ?  path : File.join( type, path )
      paths = Dir[File.expand_path( File.join( File.dirname(__FILE__), path ) ), File.join(".", path)]
      
      @content = paths.map{|file| File.read(file) }.join("/n")

      @content.empty? and raise "Could not find #{path} in any of the expected directories.  Please verify that it exists."
      @stages = Hash.new
      instance_eval @content
    end

    %w[requirements cook cleanup].each do |stage|
      define_method(stage) {|&block| @stages[stage] = block}

      define_method("execute_#{stage}") do
        execute_requirements unless stage == "requirements"
        @stages[stage].call
      end
    end

    def execute_taste
      $dry = true
      execute_cook
      execute_cleanup
    end

    def add_spices(&block)
      @stages["spices"] = Trollop::Parser.new(&block)
      @spices = @stages["spices"].parse
    end
    
    def add_ingredient *args; execute Ingredient, :execute_cook, *args; end
    def clean_ingredient *args ; execute Ingredient, :execute_cleanup, *args; end
    def help ; @stages["spices"].educate ; end

    protected
    def execute type, method, path, opts={}
      item = type.new path
      item.spices.merge! opts
      item.send method
    end
  end
end