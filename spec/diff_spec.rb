RSpec.describe TKSeal::Diff do
  before(:each) do
    @ss_dbl = instance_double(TKSeal::SecretState, plain_secrets: "", kube_secrets: "")
  end
  subject do
    described_class.new(@ss_dbl)
  end
  context "#pull" do
    it "returns 'No differences' for no differences" do
      expect { subject.pull }.to output("No differences\n").to_stdout
    end
    it "prints comparison of plain to kube when there are differences" do
      allow(@ss_dbl).to receive(:plain_secrets).and_return("Hello")
      expect { subject.pull }.to output(/-Hello/).to_stdout
    end
  end
  context "#plain" do
    it "returns 'No differences' for no differences" do
      expect { subject.plain }.to output("No differences\n").to_stdout
    end
    it "prints comparison of plain to kube when there are differences" do
      allow(@ss_dbl).to receive(:plain_secrets).and_return("Hello")
      expect { subject.plain }.to output(/\+Hello/).to_stdout
    end
  end
end
