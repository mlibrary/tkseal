module TKSeal
  class CLI < Thor
    desc("diff PATH", "shows difference between local plain secret and kuberentes secret for a given tk enviornment PATH")
    def diff(path)
      say("This shows what would change in the cluster based on \"plain_secrets.json\"", :yellow)
      ss = TKSeal::SecretState.new(path)
      Diff.new(ss).plain
    end

    desc("pull PATH", "pulls copy of opaque secrets from kubernetes")
    def pull(path)
      ss = TKSeal::SecretState.new(path)
      Diff.new(ss).pull
      if yes?("Are you sure?")
        File.write(ss.plain_secrets_file_path, ss.kube_secrets)
      end
    end
  end
end
