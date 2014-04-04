require "rake/testtask"

require 'rubocop/rake_task'
Rubocop::RakeTask.new

task default: [:test, :rubocop]

Rake::TestTask.new(:test) do |t|
  t.libs << "lib"
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
  t.verbose = false
end
