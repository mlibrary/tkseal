module TKSeal
  class Diff
    attr_reader :secret_state
    def initialize(secret_state)
      @secret_state = secret_state
    end

    def pull
      # changes that pulling the kube secrets into plain would make
      output = Diffy::Diff.new(@secret_state.plain_secrets, @secret_state.kube_secrets).to_s
      if output == "\n"
        puts "No differences"
      else
        puts output
      end
    end

    def plain
      # changes that would be made to kube by plain secrets
      output = Diffy::Diff.new(@secret_state.kube_secrets, @secret_state.plain_secrets).to_s
      if output == "\n"
        puts "No differences\n"
      else
        puts output
      end
    end
  end
end
