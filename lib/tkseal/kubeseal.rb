module TKSeal
  class Kubeseal
    # :nocov:
    def self.exists?
      `which kubeseal` != ""
    end

    def self.seal(context:, namespace:, name:, value:)
      `printf "%s" "#{value}" | kubeseal --raw --namespace #{namespace} --name #{name} --context #{context}`
    end
    # :nocov:
  end
end
