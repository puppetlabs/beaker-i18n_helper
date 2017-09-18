# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "beaker/i18n_helper/version"

Gem::Specification.new do |spec|
  spec.name          = "beaker-i18n_helper"
  spec.version       = Beaker::I18nHelper::VERSION
  spec.authors       = ["Eric Putnam"]
  spec.email         = ["putnam.eric@gmail.com"]

  spec.summary       = %q{Ruby gem to help with testing i18n with Beaker}
  spec.homepage      = "https://github.com/puppetlabs/beaker-i18n_helper"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

end
