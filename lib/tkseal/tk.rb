module TKSeal
  class TK
    def self.exists?
      `which tk` != ""
    end

    def self.status(path)
      `tk status #{path}`
    end
  end
end
