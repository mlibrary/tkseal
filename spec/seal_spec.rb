require "tempfile"
RSpec.describe TKSeal::Seal do
  before(:each) do
    @secret_state = instance_double(TKSeal::SecretState, context: "context", namespace: "namespace")
    @kubeseal_dbl = class_double(TKSeal::Kubeseal, seal: "sealed_secret")
  end
  subject do
    described_class.new(@secret_state, @kubeseal_dbl)
  end
  context "#kubeseal" do
    it "calls the wrapper with the appropriate arguments and returns a secret" do
      expect(@kubeseal_dbl).to receive(:seal).with(context: "context", namespace: "namespace", name: "name", value: "value")
      expect(subject.kubeseal(name: "name", value: "value")).to eq("sealed_secret")
    end
  end
  context "#run" do
    before(:each) do
      @sealed_secret_file = Tempfile.new
      allow(@secret_state).to receive(:plain_secrets).and_return(
        [
          {
            name: "name",
            data: {
              "EXAMPLE_SECRET" => "example_secret_value"
            }
          }
        ].to_json
      )

      allow(@secret_state).to receive(:sealed_secrets_file_path).and_return(@sealed_secret_file.path)
    end
    after(:each) do
      @sealed_secret_file.close
      @sealed_secret_file.unlink
    end

    it "writes expected sealed secret to the file" do
      subject.run
      @sealed_secret_file.rewind
      expect(JSON.parse(@sealed_secret_file.read)).to eq(
        [
          {
            "kind" => "SealedSecret",
            "apiVersion" => "bitnami.com/v1alpha1",
            "metadata" => {
              "name" => "name",
              "namespace" => "namespace"
            },
            "spec" => {
              "template" => {
                "metadata" => {
                  "name" => "name",
                  "namespace" => "namespace"
                }
              },
              "encryptedData" => {"EXAMPLE_SECRET" => "sealed_secret"}
            }
          }
        ]
      )
    end
  end
end
