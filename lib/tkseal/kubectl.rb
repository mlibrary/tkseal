module TKSeal
  class Kubectl
    def self.exists?
      `which kubectl` != ""
    end
  end
end
