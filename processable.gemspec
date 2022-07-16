# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "processable"
  spec.version       = "0.0.1"
  spec.authors       = ["Max Rukomoynikov"]
  spec.email         = ["rukomoynikov@gmail.com"]

  spec.summary       = "Ruby gem to help you organize any process into series of steps"
  spec.homepage      = "https://github.com/Rukomoynikov/processable"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Rukomoynikov/processable"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end

  spec.require_paths = ["lib"]
end
