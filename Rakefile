require "rubygems"
require "hoe"
require "rake/extensiontask"

require "./lib/johnson/version.rb"

HOE = Hoe.new "johnson", Johnson::VERSION do |p|
  p.developer "John Barnette",   "jbarnette@rubyforge.org"
  p.developer "Aaron Patterson", "aaron.patterson@gmail.com"
  p.developer "Yehuda Katz",     "wycats@gmail.com"
  p.developer "Matthew Draper",  "matthew@trebex.net"

  p.history_file     = "CHANGELOG.rdoc"
  p.readme_file      = "README.rdoc"
  p.summary          = "Johnson wraps JavaScript in a loving Ruby embrace."
  p.url              = "http://github.com/jbarnette/johnson/wikis"

  p.extra_rdoc_files = [p.readme_file]
  p.test_globs       = %w(test/**/*_test.rb)

  p.clean_globs     << "lib/johnson/spidermonkey.bundle"
  p.clean_globs     << "tmp"
  p.clean_globs     << "vendor/spidermonkey/**/*.OBJ"
  p.clean_globs     << "ext/**/*.{o,so,bundle,a,log}"

  p.extra_deps      << "rake"
  p.extra_dev_deps  << "rake-compiler"
  p.spec_extras      = { :extensions => %w(Rakefile) }
end

Rake::ExtensionTask.new "spidermonkey", HOE.spec do |ext|
  ext.lib_dir = "lib/johnson"
end

task :test => :compile

Dir["lib/tasks/*.rake"].each { |f| load f }

# HACK: If Rake is running as part of the gem install, clear out the
# default task and make the extensions compile instead.

Rake::Task[:default].prerequisites.replace %w(compile) if ENV["RUBYARCHDIR"]

begin
  require 'ffi-swig-generator'
  FFI::Generator::Task.new do |task|
    task.input_fn = 'interfaces/*.i'
    task.output_dir = 'generated/'
  end
rescue LoadError
  nil
end
