module TKSeal
  class Kubeseal
    def self.exists?
      `which kubeseal` != ""
    end

    def self.seal(context:, namespace:, name:, value:)
      `echo -n #{value} | kubeseal --raw --namespace #{namespace} --name #{name} --context #{context}`
    end
  end
end
