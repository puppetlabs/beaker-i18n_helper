source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in beaker-i18n_helper.gemspec
gemspec

group :test do
  gem 'rubocop'
  gem 'rake', '~> 10.0'
  gem 'rspec', '~> 3.0'
  gem 'beaker', '>= 3.0.0'
  gem 'json'
end

group :development do
  # TODO: Use gem instead of git. Section mapping is merged into master, but not yet released
  gem 'github_changelog_generator', git: 'https://github.com/skywinder/github-changelog-generator.git', ref: '33f89614d47a4bca1a3ae02bdcc37edd0b012e86'
  gem 'pry'
end
