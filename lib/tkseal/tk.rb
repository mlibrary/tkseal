module TKSeal
  class TK
    def self.exists?
      `which tk` != ""
    end

    def self.status(path)
      status = `tk status #{path}`
      raise TKSeal::Error.new("TKSeal Error: No Tanka environment at path: \"#{path}\"") if status == ""
      status
    rescue TKSeal::Error => e
      puts e.message
      exit
    end

    class Environment
      attr_reader :status
      def initialize(path, status = TK.status(path))
        @status = status.split("\n").map { |x| x.strip }
      end

      def context
        get_val("Context")
      end

      def namespace
        get_val("Namespace")
      end

      def get_val(key)
        @status.find { |x| x.match?("#{key}: ") }.sub("#{key}: ", "")
      end
    end
  end
end
