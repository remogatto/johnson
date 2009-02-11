require "rake/lathertask"
require "rake/testtask"

test = Rake::TestTask.new do |t|
  t.libs      << "test"
  t.ruby_opts << "-rubygems -rhelper"
  t.pattern    = "test/**/*_test.rb"
end

task :default => :test

Rake::LatherTask.new :target => test do |lather|
  lather.globs << "lib/**/*.rb"
  lather.globs << "ext/**/*.{c,cc,h}"
end
