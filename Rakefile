require 'bundler/gem_tasks'
require 'rake/testtask'

task :default => ["test:units"]

desc "Run basic tests"
Rake::TestTask.new("test:units") do |t|
  t.pattern = 'test/test_*.rb'
  t.verbose = true
  t.warning = false
end

desc "Run the integration tests"
Rake::TestTask.new("test:integration") do |t|
  t.pattern = 'test/integration/test_*.rb'
  t.verbose = true
  t.warning = false
end
