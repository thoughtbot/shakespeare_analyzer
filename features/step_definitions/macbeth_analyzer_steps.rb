When /^macbeth_analyzer is run with "(.*)"$/ do |file|
  path = File.expand_path("#{File.dirname(__FILE__)}/../../lib/macbeth_analyzer.rb")
  steps %{
    When I run `#{path} #{file}`
  }
end
