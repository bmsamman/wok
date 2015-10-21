# in case active_support/inflector is required without the rest of active_support
$:.unshift File.expand_path(File.dirname(__FILE__))
require 'inflector/inflections'
require 'inflector/methods'

require 'inflections'
require 'core_ext/string/inflections'
