module TKSeal
  class SecretState
    extend Forwardable
    def_delegators :@tk_env, :context, :namespace
    attr_reader :plain_secrets_file_path, :sealed_secrets_file_path
    def initialize(tk_env_path, configuration = TKSeal::Configuration, tk_env_getter = TKSeal::TK::Environment)
      @tk_env_path = tk_env_path.sub(/\/(\w+.jsonnet)?$/, "")
      @tk_env = tk_env_getter.new(@tk_env_path)
      @plain_secrets_file_path = "#{@tk_env_path}/#{configuration.plain_secrets_file}"
      @sealed_secrets_file_path = "#{@tk_env_path}/#{configuration.sealed_secrets_file}"
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
