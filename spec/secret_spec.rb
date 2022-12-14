RSpec.describe Secret do
  before(:each) do
    @secret = YAML.safe_load(fixture("secrets.yaml"))[0]
  end
  subject do
    described_class.new(@secret)
  end
  context "#name" do
    it "gets the name from the correct field" do
      expect(subject.name).to eq("example")
    end
  end

  context "#data (returns an array of objects)" do
    it "key is the key" do
      expect(subject.data.first.key).to eq("EXAMPLE_SECRET")
    end
    it "plain_value is the raw unencode value" do
      expect(subject.data.first.plain_value).to eq("example_secret")
    end
    it "encoded_value is the base64 encoded value" do
      expect(subject.data.first.encoded_value).to eq("ZXhhbXBsZV9zZWNyZXQ=")
    end
  end
end
