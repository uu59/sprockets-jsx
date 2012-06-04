# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.authors       = ["uu59"]
  gem.email         = ["k@uu59.org"]
  gem.description   = %q{JSX support for Sprockets}
  gem.summary       = %q{JSX support for Sprockets}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "sprockets-jsx"
  gem.require_paths = ["lib"]
  gem.version       = File.read(File.expand_path("../VERSION", __FILE__))
end
