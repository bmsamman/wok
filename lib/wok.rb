$:.unshift File.expand_path(File.dirname(__FILE__))
$:.unshift '.'

require 'wok/active_support/inflector.rb'
require 'wok/wok_helpers.rb'

module Wok
  autoload :Commands, 'wok/commands.rb'
  autoload :Parsable, 'wok/parsable.rb'
  autoload :Recipe, 'wok/recipe.rb'
  autoload :Ingredient, 'wok/ingredient.rb'
end

include Wok::Commands
