require 'aruba'
require 'aruba/in_process'
require 'aruba/cucumber'
require_relative '../../macbeth_analyzer'

Aruba::InProcess.main_class = MyMain
Aruba.process = Aruba::InProcess

Before do
  @dirs = ["."]
end
