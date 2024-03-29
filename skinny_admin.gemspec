# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'skinny_admin/version'

Gem::Specification.new do |spec|
  spec.name          = "skinny_admin"
  spec.version       = SkinnyAdmin::VERSION
  spec.authors       = ["Brad Saterfiel"]
  spec.email         = ["brad.saterfiel@gmail.com"]
  spec.summary       = "SkinnyAdmin is an admin template generator that is easy, quick, and painless to get going.  No DSL involved."
  spec.description   = "Easily customizable admin generator for Rails.  SkinnyAdmin is very easy to install and get your customized administrative needs met quickly."
  spec.homepage      = "https://skinnyadmin.org"
  spec.license       = "MIT"
  spec.platform      = Gem::Platform::RUBY
  spec.rubygems_version

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "bundler", ">= 2.2.33"
end
