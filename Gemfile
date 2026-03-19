# frozen_string_literal: true

source "https://rubygems.org"

ruby "~> 3.4.0"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "functions_framework"
gem "kagaribi"
gem "sentry-ruby"
gem "simple_oauth", ">= 0.4.0"
gem "simple_twitter", ">= 2.0.0"
gem "twitter_oauth2"
gem "uri", ">= 0.12.2" # for CVE-2023-36617

# FIXME: ffi v1.17.0+ provides pre-compiled gem (e.g. x86_64-linux-gnu), but Cloud Run Functions supports only x86_64-linux platform (maybe)
#
# ERROR: (gcloud.beta.functions.deploy) OperationError: code=3, message=Build failed with status: FAILURE and message: Fetching gem metadata from https://rubygems.org/..........
# Your bundle is locked to ffi (1.17.1-x86_64-linux) from rubygems repository
# https://rubygems.org/ or installed locally, but that version can no longer be
# found in that source. That means the author of ffi (1.17.1-x86_64-linux) has
# removed it. You'll need to update your bundle to a version other than ffi
# (1.17.1-x86_64-linux) that hasn't been removed in order to install..
#
# c.f. 
# * https://github.com/sue445/pribirthdaybot/actions/runs/13590245164/job/37994362842
# * https://github.com/GoogleCloudPlatform/buildpacks/issues/508
gem "ffi", "< 1.17.0"

# FIXME: google-protobuf v4.31.0+ provides pre-compiled gem (e.g. x86_64-linux-gnu), but Cloud Run Functions supports only x86_64-linux platform (maybe)
#
# ERROR: (gcloud.beta.functions.deploy) OperationError: code=3, message=Build failed with status: FAILURE and message: Fetching gem metadata from https://rubygems.org/..........
# Your bundle is locked to google-protobuf (4.31.0-x86_64-linux) from rubygems
# repository https://rubygems.org/ or installed locally, but that version can no
# longer be found in that source. That means the author of google-protobuf
# (4.31.0-x86_64-linux) has removed it. You'll need to update your bundle to a
# version other than google-protobuf (4.31.0-x86_64-linux) that hasn't been
# removed in order to install..
#
# c.f. 
# * https://github.com/sue445/pribirthdaybot/issues/158
# * https://github.com/GoogleCloudPlatform/buildpacks/issues/508
gem "google-protobuf", "< 4.31.0"

# FIXME: There is no x86-linux gem after 1.74.0+.
#        Due to the following issues, deployment to Cloud Run functions has failed, so I'm locking at 1.73.
#        https://github.com/GoogleCloudPlatform/buildpacks/issues/508
gem "grpc", "< 1.74.0"

group :test do
  gem "rspec"
  gem "rspec-its"
  gem "webmock", require: "webmock/rspec"
end
