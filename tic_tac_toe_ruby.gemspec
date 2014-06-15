# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name          = "tic_tac_toe_ruby"
  gem.version       = "0.0.1"
  gem.summary       = %q{Tic Tac Toe in ruby}
  gem.description   = %q{Unbeatable AI for Tic Tac Toe in ruby}
  gem.license       = "MIT"
  gem.authors       = ["Felipe Sere"]
  gem.email         = "felipesere@gmail.com"
  gem.homepage      = "https://github.com/felipesere/tic_tac_toe_ruby#readme"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'rake', '~> 0.8'
  gem.add_development_dependency 'rdoc', '~> 3.0'
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
end
