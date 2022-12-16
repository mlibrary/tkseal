module TKSeal
  class CLI < Thor
    def self.exit_on_failure?
      true
    end
    desc("diff PATH", "shows difference between \"plain_secrets.json\" and kuberentes secrets for a given tk enviornment PATH")
    def diff(path)
      ss = TKSeal::SecretState.new(path)
      say("This shows what would change in the cluster based on \"plain_secrets.json\"", :yellow)
      Diff.new(ss).plain
    end

    desc("pull PATH", "pulls copy of Opaque secrets from kubernetes")
    def pull(path)
      ss = TKSeal::SecretState.new(path)
      say("This shows how \"plain_secrets.json\" would change based on what's in the kubernetes cluster", :yellow)
      Diff.new(ss).pull
      if yes?("Are you sure?")
        File.write(ss.plain_secrets_file_path, ss.kube_secrets)
      end
    end

    desc("seal PATH", "seals the \"unencrypted_secrets.json\" file for the given tk environment PATH")
    def seal(path)
      ss = TKSeal::SecretState.new(path)
      say("This shows what would change in the cluster based on \"plain_secrets.json\"", :yellow)
      if yes?("Are you sure?")
        TKSeal::Seal.new(ss).run
      end
    end
  end
end
