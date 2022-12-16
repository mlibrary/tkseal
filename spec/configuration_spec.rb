RSpec.describe TKSeal::Configuration do
  it "returns the expected plain_secrets_file" do
    expect(described_class.plain_secrets_file).to eq("plain_secrets.json")
  end
  it "returns the expected sealed_secrets_file" do
    expect(described_class.sealed_secrets_file).to eq("sealed_secrets.json")
  end
end
