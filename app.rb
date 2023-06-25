# frozen_string_literal: true

ENV["RACK_ENV"] ||= "development"
Bundler.require(:default, ENV["RACK_ENV"])

require_relative "lib/bot"

FunctionsFramework.cloud_event("pribirthdaybot") do |_request|
  Bot.new.perform
end
