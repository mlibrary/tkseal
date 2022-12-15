RSpec.describe TKSeal::Secrets do
  before(:each) do
    @secrets = YAML.safe_load(fixture("secrets.yaml"))
  end
  subject do
    described_class.new(@secrets)
  end
  context "#list" do
    it "returns an array of opaque secrets" do
      list = subject.list
      expect(list.count).to eq(1)
      expect(list.first.name).to eq("example")
    end
  end
  context "#to_json" do
    it "returns expected json string" do
      json_string = JSON.pretty_generate(
        [
          {
            name: "example",
            data: {
              EXAMPLE_SECRET: "example_secret"
            }
          }
        ]
      )
      expect(subject.to_json).to eq(json_string)
    end
  end
end
RSpec.describe TKSeal::Secret do
  before(:each) do
    @secret = YAML.safe_load(fixture("secrets.yaml"))["items"][0]
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
