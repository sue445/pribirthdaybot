Bundler.require(:default)

require_relative "./birthday_calendar_client"

class Bot
  def perform
    Time.zone = "Tokyo"
    today = Time.current.to_date

    names = BirthdayCalendarClient.new.find_by_birthday(today)

    if names.empty?
      puts "#{today} is not nobody's birthday"
      return
    end

    message = generate_birthday_message(today.year, names)
    post_tweet(message)
  end

  # @param year [Integer]
  # @param names [Array<String>]
  def generate_birthday_message(year, names)
    message = "今日は"
    message << names.join("、")
    message << "の誕生日です！"

    names.each do |name|
      message << " ##{name}誕生祭#{year}"
      message << " ##{name}生誕祭#{year}"
    end

    message
  end

  private

  def post_tweet(tweet)
    twitter_client.update(tweet)
    puts tweet
  end

  def twitter_client
    @twitter_client ||=
      Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
        config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
        config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
      end
  end
end
