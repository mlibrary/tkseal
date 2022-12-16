module TKSeal
  # :nocov:
  class Kubectl
    def self.exists?
      `which kubectl` != ""
    end

    def self.get_secrets(context:, namespace:)
      YAML.safe_load(`kubectl --context=#{context} --namespace=#{namespace} get secrets -o yaml`)
    end
  end
  # :nocov:
end
