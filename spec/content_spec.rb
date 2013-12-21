require_relative '../lib/content'
describe Content do
  before do
    @content = Content.new("")
  end
  subject { @content }
  it {should respond_to(:source)}
  it {should respond_to(:data)}
  it {should respond_to(:get_content_from_source)}
end