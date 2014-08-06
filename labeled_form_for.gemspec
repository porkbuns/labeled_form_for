# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'labeled_form_for/version'

Gem::Specification.new do |spec|
  spec.name          = "labeled_form_for"
  spec.version       = LabeledFormFor::VERSION
  spec.authors       = ["Matt McCray", "Hsiu-Fan Wang"]
  spec.email         = ["hfwang@porkbuns.net"]
  spec.summary       = %q{Automatically creates field labels, and surrounds the form markup using Data-Definition Lists.}
  spec.description   = %q{Automatically creates field labels, and surrounds the form markup using Data-Definition Lists.}
  spec.homepage      = "http://mattmccray.com/svn/rails/plugins/labeled_form_builder"
  spec.license       = "MIT"

  spec.files         = [".gitignore", "Gemfile", "INSTALL", "LICENSE", "README", "Rakefile", "labeled_form_for.gemspec", "lib/labeled_form_for.rb", "lib/labeled_form_for/labeled_form_builder.rb", "lib/labeled_form_for/labeled_form_helper.rb", "lib/labeled_form_for/version.rb"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
