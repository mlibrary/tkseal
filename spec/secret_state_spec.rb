RSpec.describe TKSeal::SecretState do
  context "path that ends in a directory" do
    it "has the expected paths" do
      state = described_class.new("some/path", TKSeal::Configuration, class_double(TKSeal::TK::Environment, new: nil))
      expect(state.plain_secrets_file_path).to eq("some/path/plain_secrets.json")
      expect(state.sealed_secrets_file_path).to eq("some/path/sealed_secrets.json")
    end
  end
  context "path that ends in a directory with extra slash" do
    it "has the expected paths" do
      state = described_class.new("some/path/", TKSeal::Configuration, class_double(TKSeal::TK::Environment, new: nil))
      expect(state.plain_secrets_file_path).to eq("some/path/plain_secrets.json")
      expect(state.sealed_secrets_file_path).to eq("some/path/sealed_secrets.json")
    end
  end
  context "path that ends in a directory with a jsonnet file" do
    it "has the expected paths" do
      state = described_class.new("some/path/main.jsonnet", TKSeal::Configuration, class_double(TKSeal::TK::Environment, new: nil))
      expect(state.plain_secrets_file_path).to eq("some/path/plain_secrets.json")
      expect(state.sealed_secrets_file_path).to eq("some/path/sealed_secrets.json")
    end
  end
end
