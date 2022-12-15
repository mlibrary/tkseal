module TKSeal
  class Secrets
    attr_reader :list
    def initialize(raw)
      @list = raw["items"].filter do |x|
        x["type"] == "Opaque"
      end.map do |x|
        Secret.new(x)
      end
    end

    def to_json
      ::JSON.pretty_generate(
        @list.map do |secret|
          {
            name: secret.name,
            data: secret.data.map { |pair| [pair.key, pair.plain_value] }.to_h
          }
        end
      )
    end
  end

  class Secret
    def initialize(raw)
      @raw = raw
    end

    def name
      @raw["metadata"]["name"]
    end

    def data
      @raw["data"].to_a.map do |pair|
        OpenStruct.new(
          key: pair[0],
          plain_value: Base64.strict_decode64(pair[1]),
          encoded_value: pair[1]
        )
      end
    end
  end
end
