require_relative 'lib/macbeth_analyzer'

if ARGV.first == "one_step"
  puts "using one_step_analyze"
  puts "----------------------"
  puts ""
  MacbethAnalyzer.new.output(one_step: true).each { |o| puts o }
else
  MacbethAnalyzer.new.output.each {|o| puts o }
end