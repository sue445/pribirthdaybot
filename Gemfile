# frozen_string_literal: true

source "https://rubygems.org"

ruby "~> 3.2.0"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "activesupport", require: "active_support/all"
gem "functions_framework"
gem "google-cloud-firestore", require: "google/cloud/firestore"
gem "sentry-ruby"

# TODO: Use upstream after my patches are merged
# gem "simple_twitter"
gem "simple_twitter", github: "sue445/simple_twitter", branch: "develop"

gem "twitter_oauth2"
gem "uri", ">= 0.12.2" # for CVE-2023-36617

group :test do
  gem "rspec"
  gem "rspec-its"
  gem "webmock", require: "webmock/rspec"
end
