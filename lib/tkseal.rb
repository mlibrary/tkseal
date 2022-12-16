# frozen_string_literal: true

require "yaml"
require "json"
require "base64"
require "ostruct"
require "diffy"
require "thor"

require_relative "tkseal/version"
require_relative "tkseal/secret"
require_relative "tkseal/secret_state"
require_relative "tkseal/diff"
require_relative "tkseal/seal"
require_relative "tkseal/tk"
require_relative "tkseal/kubectl"
require_relative "tkseal/kubeseal"
require_relative "tkseal/cli"

module TKSeal
  Diffy::Diff.default_format = :color
  class Error < StandardError; end

  def self.ready?
    Kubectl.exists? && TK.exists? && Kubeseal.exists?
  end

  # Your code goes here...
  class Configuration
    def self.plain_secrets_file
      "plain_secrets.json"
    end

    def self.sealed_secrets_file
      "sealed_secrets.json"
    end
  end
end
