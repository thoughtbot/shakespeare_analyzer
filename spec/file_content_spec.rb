require_relative '../lib/file_content'
describe FileContent do
  before do
    @content = FileContent.new("macbeth.xml")
  end
  subject { @content }
  it {should respond_to(:source)}
  it {should respond_to(:data)}
  describe "#get_content_from_source" do
    it "should return a Nokigiri document" do
      expect(@content.data.class).to eq(Nokogiri::XML::Document)
    end
  end
end