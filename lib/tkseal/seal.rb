module TKSeal
  class Seal
    def initialize(secret_state, kubeseal_wrapper = TKSeal::Kubeseal)
      @secret_state = secret_state
      @kubeseal_wrapper = kubeseal_wrapper
    end

    def run
      plain_secrets = JSON.parse(@secret_state.plain_secrets)
      sealed_secrets = plain_secrets.map do |secret|
        {
          kind: "SealedSecret",
          apiVersion: "bitnami.com/v1alpha1",
          metadata: {
            name: secret["name"],
            namespace: @secret_state.namespace
          },
          spec: {
            template: {
              metadata: {
                name: secret["name"],
                namespace: @secret_state.namespace
              }
            },
            encryptedData: secret["data"].to_a.map do |pair|
              [pair[0], kubeseal(name: secret["name"], value: pair[1])]
            end.to_h
          }
        }
      end
      File.write(@secret_state.sealed_secrets_file_path, JSON.pretty_generate(sealed_secrets))
    end

    def kubeseal(name:, value:)
      @kubeseal_wrapper.seal(context: @secret_state.context, namespace: @secret_state.namespace, name: name, value: value)
    end
  end
end
