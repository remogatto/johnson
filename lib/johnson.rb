require "generator"
require "johnson/version"

# # the command-line option parser and support libs
require "johnson/cli"

# # visitable module and visitors
# require "johnson/visitable"
# require "johnson/visitors"

# # parse tree nodes
# require "johnson/nodes"

if ENV['JOHNSON_FFI'] || RUBY_PLATFORM =~ /java/
  gem 'ffi', '>=0.3.2' unless RUBY_PLATFORM =~ /java/
  require 'ffi'
  require 'johnson/spidermonkey/ffi-spidermonkey.rb'
  require 'johnson/spidermonkey/ruby_land_proxy.rb'
  require 'johnson/spidermonkey/js_land_proxy.rb'
  require 'johnson/spidermonkey/conversions'
  require 'johnson/spidermonkey/runtime'
else
  # load the standard extension
end

# # the 'public' interface
require "johnson/error"
require "johnson/runtime"
# require "johnson/parser"

# make sure all the Johnson JavaScript libs are in the load path
$LOAD_PATH.push(File.expand_path("#{File.dirname(__FILE__)}/../js"))

module Johnson
  PRELUDE = IO.read(File.dirname(__FILE__) + "/../js/johnson/prelude.js")
  
  def self.evaluate(expression, vars={})
    runtime = Johnson::Runtime.new
    vars.each { |key, value| runtime[key] = value }
    
    runtime.evaluate(expression)
  end
  
  def self.parse(js, *args)
    Johnson::Parser.parse(js, *args)
  end

  ###
  # Create a new runtime and load all +files+.  Returns a new Johnson::Runtime.
  def self.load(*files)
    rt = Johnson::Runtime.new
    rt.load(*files)
    rt
  end
end
