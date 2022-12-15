# frozen_string_literal: true

require "yaml"
require "json"
require "base64"
require "ostruct"
require "diffy"

require_relative "tkseal/version"
require_relative "tkseal/secret"
require_relative "tkseal/tk"
require_relative "tkseal/kubectl"

module TKSeal
  class Error < StandardError; end
  # Your code goes here...
end
