module TKSeal
  class Diff
    PLAIN_SECRETS_FILE = "plain_secrets.json"
    SEALED_SECRETS_FILE = "sealed_secrets.json"
    attr_reader :kube_secrets
    def initialize(tk_env_path)
      @tk_env_path = tk_env_path.strip.sub(/\/$/, "")
      @kube_secrets = get_kube_secrets
    end

    def plain
      puts Diffy::Diff.new(kube_secrets, plain_secrets).to_s(:color)
    end

    def plain_secrets
      File.read("#{tk_env_path}/#{PLAIN_SECRETS_FILE}")
    rescue
      ""
    end

    def get_kube_secrets(secrets_class = TKSeal::Secrets)
      secrets_class.for_tk_env(@tk_env_path).to_json
    end
  end
end
