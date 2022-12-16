module TKSeal
  class CLI < Thor
    def self.exit_on_failure?
      true
    end
    desc("diff PATH", "Shows the difference between \"plain_secrets.json\" and the Opaque kuberentes secrets associated with the tk environment PATH")
    long_desc <<-LONGDESC
      `tkseal diff PATH` will compare the secrets in "plain_secrets.json" in the given tanka enviroment PATH
      with the Opaque secrets that are in the cluster associated with the tanka environment.
    LONGDESC
    def diff(path)
      raise TKSeal::Error.new("TKSeal Error: a dependency is missing. run `tkseal ready` to find out what.") unless TKSeal.ready?
      ss = TKSeal::SecretState.new(path)
      say("This shows what would change in the cluster based on \"plain_secrets.json\"", :yellow)
      Diff.new(ss).plain
    rescue TKSeal::Error => e
      say(e.message, :red)
    end

    desc("pull PATH", "Saves the Opaque kubernetes secrets associated with the tk enviornment PATH to a file")
    long_desc <<-LONGDESC
      `tkseal pull PATH` will save a copy of the unencrypted Opaque 
      secrets in the kubernetes cluster associated with the given 
      tanka environment PATH to the file "plain_secrets.json", which is also located in the 
      given tanka environment PATH.
    LONGDESC
    def pull(path)
      raise TKSeal::Error.new("TKSeal Error: a dependency is missing. run `tkseal ready` to find out what.") unless TKSeal.ready?
      ss = TKSeal::SecretState.new(path)
      say("This shows how \"plain_secrets.json\" would change based on what's in the kubernetes cluster", :yellow)
      Diff.new(ss).pull
      if yes?("Are you sure?")
        File.write(ss.plain_secrets_file_path, ss.kube_secrets)
      end
    rescue TKSeal::Error => e
      say(e.message, :red)
    end

    desc("seal PATH", "Seals the \"plain_secrets.json\" file for the given tk environment PATH")
    long_desc <<-LONGDESC
      `tkseal seal PATH` will take the secrets in "plain_secerets.json" in the given tanka environment PATH,
      seal them with `kubeseal` and save the resulting sealed secrets to "sealed_secrets.json" in the given 
      tanka environment path.
    LONGDESC
    def seal(path)
      raise TKSeal::Error.new("TKSeal Error: a dependency is missing. run `tkseal ready` to find out what.") unless TKSeal.ready?
      ss = TKSeal::SecretState.new(path)
      say("This shows what would change in the cluster based on \"plain_secrets.json\"", :yellow)
      Diff.new(ss).plain
      if yes?("Are you sure?")
        TKSeal::Seal.new(ss).run
      end
    rescue TKSeal::Error => e
      say(e.message, :red)
    end

    desc("ready", "Checks that the cli dependencies are available in your shell")
    def ready
      if TKSeal::Kubectl.exists?
        say("✅ kubectl is installed", :green)
      else
        say("❌ kubectl is NOT installed", :red)
      end
      if TKSeal::TK.exists?
        say("✅ tk is installed", :green)
      else
        say("❌ tk is NOT installed", :red)
      end
      if TKSeal::Kubeseal.exists?
        say("✅ kubeseal is installed", :green)
      else
        say("❌ kubeseal is NOT installed", :red)
      end
    end
  end
end
