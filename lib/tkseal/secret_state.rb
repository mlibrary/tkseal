module TKSeal
  class SecretState
    attr_reader :plain_secrets_file_path
    def initialize(tk_env_path, configuration = TKSeal::Configuration)
      @tk_env_path = tk_env_path
      @plain_secrets_file_path = "#{tk_env_path}/#{configuration.plain_secrets_file}"
    end

    def plain_secrets
      File.read(@plain_secrets_file_path)
    rescue
      ""
    end

    def kube_secrets(secrets = TKSeal::Secrets)
      secrets.for_tk_env(@tk_env_path)
    end
  end
end
