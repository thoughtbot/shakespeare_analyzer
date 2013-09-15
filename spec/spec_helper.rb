$LOAD_PATH.unshift(File.expand_path('../../bin', __FILE__))

require 'pp'
require 'shakespeare_analyzer'

def create_testxml(filename, text)
  File.open(filename, 'w') do |file|
    file.puts text
  end
end

#From: http://stackoverflow.com/questions/11349270/test-output-to-command-line-with-rspec
#Capturing CLI output
#Usage:
#output = capture_stdout { Hello.new.speak }
#output.should == "Hello from RSpec\n"
module Kernel
  def capture_stdout(&block)
    $stdout = fake = StringIO.new
    begin
      yield
      return fake.string
    ensure
      $stdout = STDOUT
    end
    return
    fake.string
  end
end
