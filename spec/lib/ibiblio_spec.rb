require 'ibiblio'

describe Ibiblio do
  describe ":find" do
    let!(:request) { stub_request(:get, "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml") }

    it "makes a request to ibiblio.org" do
      Ibiblio.find('Macbeth')
      expect(request).to have_been_made
    end
  end
end
