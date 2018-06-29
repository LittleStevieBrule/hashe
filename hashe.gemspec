
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hashe/version'

Gem::Specification.new do |spec|
  spec.name          = 'hashe'
  spec.version       = Hashe::VERSION
  spec.authors       = %w[LittleStevieBrule StephenMcGuckinDAT]
  spec.email         = %w[stephendmcguckin@gmail.com]

  spec.summary       = 'Hash with dynamic setters and getters'
  spec.homepage      = 'https://github.com/LittleStevieBrule/hashe'
  spec.license       = 'MIT'

  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
end
