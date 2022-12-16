# frozen_string_literal: true

require_relative "lib/tkseal/version"

Gem::Specification.new do |spec|
  spec.name = "tkseal"
  spec.version = TKSeal::VERSION
  spec.authors = ["Monique Rio"]
  spec.email = ["mrio@umich.edu"]

  spec.summary = "CLI to aid in sealed secrets for tanka config repository"
  spec.description = "CLI to aid in sealed secrets for tanka config repository"
  spec.homepage = "https://github.com/mlibrary/tkseal"
  spec.license = "BSD-3-Clause"
  spec.required_ruby_version = ">= 2.7"

  spec.metadata["allowed_push_host"] = "https://rubygems.pkg.github.com/mlibrary"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mlibrary/tkseal"
  spec.metadata["changelog_uri"] = "https://github.com/mlibrary/tkseal/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git))})
    end
  end
  spec.bindir = "exe"
  spec.executables = ["tkseal"]
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "diffy", "~> 3.4", ">= 3.4.2"
  spec.add_development_dependency "rspec", "~> 3.12"
  spec.add_development_dependency "standard"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "simplecov"

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
