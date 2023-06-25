# frozen_string_literal: true

ENV["RACK_ENV"] ||= "development"
Bundler.require(:default, ENV["RACK_ENV"])

require_relative "lib/bot"

Sentry.init

# @param function_name [String]
def with_sentry(function_name)
  Sentry.set_tags(function_name:)

  yield
rescue Exception => e
  Sentry.capture_exception(e)
  raise e
end

FunctionsFramework.cloud_event("pribirthdaybot") do |_request|
  with_sentry("pribirthdaybot") do
    Bot.new.perform
  end
end
