source 'https://rubygems.org'

# Specify your gem's dependencies in errawr.gemspec
gemspec

group :development do
  gem 'bundler'
  gem 'coveralls', require: false
  gem 'rake'
end

group :test do
  gem 'rspec'
  gem 'simplecov'
end

platforms :rbx do
  gem 'racc'
  gem 'rubinius-coverage', github: 'rubinius/rubinius-coverage'
  gem 'rubysl'
end