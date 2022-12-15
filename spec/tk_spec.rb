RSpec.describe TKSeal::TK::Environment do
  before(:each) do
    @status = fixture("tk_status.txt") { |io| io.read }
  end
  subject do
    described_class.new("", @status)
  end
  context "#context" do
    it "returns the context" do
      expect(subject.context).to eq("some-context")
    end
  end
  context "#namespace" do
    it "returns the namespace" do
      expect(subject.namespace).to eq("some-namespace")
    end
  end
end
