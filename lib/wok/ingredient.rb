module Wok
  class Ingredient < Parsable
    def initialize file
      super( 'ingredients', file )
    end
  end
end