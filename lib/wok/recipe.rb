module Wok
  class Recipe < Parsable
    def initialize file; super( "recipes", file ); end
    def add_recipe *args; execute Recipe, :execute_cook, *args; end
    def clean_recipe *args; execute Recipe, :execute_cleanup, *args; end
  end
end