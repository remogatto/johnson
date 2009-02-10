require "rake/extensiontask"
require "rake/lathertask"
require "rake/testtask"

Rake::ExtensionTask.new do |ext|
  ext.name = "spidermonkey"
  ext.lib_dir = "lib/johnson"
  ext.source_pattern = "**/*.{c,h}"
end

test = Rake::TestTask.new do |t|
  t.libs      << "test"
  t.ruby_opts << "-rhelper"
  t.pattern    = "test/**/*_test.rb"
end

Rake::Task[:test].prerequisites << :compile
task :default => :test

Rake::LatherTask.new :target => test do |lather|
  lather.globs << "lib/**/*.rb"
  lather.globs << "ext/**/*.{c,cc,h}"
end
