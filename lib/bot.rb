Bundler.require(:default)

require_relative "./birthday_calendar_client"
require_relative "./twitter_client"
require_relative "./date_util"

class Bot
  def perform
    today = DateUtil.jst_date

    names = BirthdayCalendarClient.new.find_by_birthday(today)

    if names.empty?
      puts "#{today} is not nobody's birthday"
      return
    end

    message = generate_birthday_message(today, names)
    post_tweet(message)
  end

  # @param date [Date]
  # @param names [Array<String>]
  def generate_birthday_message(date, names)
    message = "#{date.month}/#{date.day}は"
    message << names.join("、")
    message << "の誕生日です！"

    if names.include?("ファララ・ア・ラーム") && names.include?("ガァララ・ス・リープ")
      message << " #ファララ生誕祭#{date.year} #ガァララ生誕祭#{date.year} #ファララガァララ生誕祭#{date.year}"
      names.reject! { |name| %w(ファララ・ア・ラーム ガァララ・ス・リープ).include?(name) }
    end

    if names.include?("ジェニファー・純恋・ソル")
      message << " #ジェニファー誕生祭#{date.year} #ジェニファー生誕祭#{date.year}"
      names.reject! { |name| %w(ジェニファー・純恋・ソル).include?(name) }
    end

    if names.include?("陽比野まつり") && names.include?("みゃむ")
      message << " #陽比野まつり生誕祭#{date.year} #みゃむ生誕祭#{date.year} #まつりみゃむ生誕祭#{date.year}"
      names.reject! { |name| %w(陽比野まつり みゃむ).include?(name) }
    end

    if names.include?("幸多みちる")
      message << " #ミーチル誕生祭#{date.year} #ミーチル生誕祭#{date.year}"
    end

    names.each do |name|
      message << " ##{name}誕生祭#{date.year}"
      message << " ##{name}生誕祭#{date.year}"
    end

    message << " https://sue445.github.io/pretty-all-friends-birthday-calendar/"

    message
  end

  private

  def post_tweet(tweet)
    puts tweet
    twitter.post_tweet(tweet)
  end

  # @return [TwitterClient]
  def twitter
    @twitter ||= TwitterClient.new("pribirthdaybot")
  end
end
