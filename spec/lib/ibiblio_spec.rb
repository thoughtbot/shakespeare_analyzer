require 'ibiblio'

shared_examples "a Catalogue" do
  subject(:catalogue) { described_class }
  it { should respond_to :find }
end

describe Ibiblio do
  it_behaves_like "a Catalogue"

  describe "finding a play" do
    context "that exists" do

    end

    context "that doesn't exist" do

    end

    let!(:request) { stub_request(:get, "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml") }

    it "makes a request to ibiblio.org" do
      Ibiblio.find('Macbeth')
      expect(request).to have_been_made
    end

    it "returns a Play" do

    end
  end
end
