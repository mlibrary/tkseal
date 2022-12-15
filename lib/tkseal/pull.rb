module TKSeal
  class Pull
    def self.run(path, secret_state_generator = TKSeal::SecretState)
      ss = secret_state_generator.new(path)
      Diff.new(ss).pull
      File.write(ss.plain_secrets_file_path, ss.kube_secrets)
    end
  end
end
