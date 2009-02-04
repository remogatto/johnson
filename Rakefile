require "rake/extensiontask"
require "rake/testtask"

Rake::ExtensionTask.new do |ext|
  ext.name = "javascriptcore"
  ext.lib_dir = "lib/johnson"
  ext.source_pattern = "**/*.{cc,h}"
end

Rake::TestTask.new do |test|
  test.libs << "test"
  test.ruby_opts << "-rhelper"
  test.test_files = FileList["test/**/*_test.rb"]
  test.verbose = false
end

Rake::Task["test"].prerequisites << :compile
task :default => :test
