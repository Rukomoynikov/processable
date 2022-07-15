# frozen_string_literal: true


Gem::Specification.new do |spec|
  spec.name          = "lined"
  spec.version       = '0.0.1'
  spec.authors       = ["Max Rukomoynikov"]
  spec.email         = ["rukomoynikov@gmail.com"]

  spec.summary       = "Write a short summary, because RubyGems requires one."
  spec.description   = "Write a longer description or delete this line."
  spec.homepage      = "http://habr.com"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://habr.com"
  spec.metadata["changelog_uri"] = "http://habr.com"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end

  spec.require_paths = ["lib"]
end
