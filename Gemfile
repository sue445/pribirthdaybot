# frozen_string_literal: true

source "https://rubygems.org"

ruby "~> 3.2.0"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "functions_framework"
gem "kagaribi"
gem "sentry-ruby"
gem "simple_twitter", ">= 2.0.0"
gem "twitter_oauth2"
gem "uri", ">= 0.12.2" # for CVE-2023-36617

group :test do
  gem "rspec"
  gem "rspec-its"
  gem "webmock", require: "webmock/rspec"
end
