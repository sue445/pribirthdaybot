namespace :bot do
  desc "Tweet birthday when today is someone's birthday"
  task :birthday do
    require_relative "./lib/bot"
    Bot.new.perform
  end
end
