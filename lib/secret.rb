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
