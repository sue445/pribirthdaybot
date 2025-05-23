Bundler.require(:default)

require_relative "./birthday_calendar_client"
require_relative "./twitter_client"
require_relative "./date_util"

class Bot
  def perform
    today = DateUtil.jst_date

    names = BirthdayCalendarClient.new.find_by_birthday(today)

    if names.empty?
      FunctionsFramework.logger.info "#{today} is not nobody's birthday"

      # Twitter API ping test
      current_user = twitter.get_me
      FunctionsFramework.logger.debug "current_user=#{current_user}"

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

    if names.include?("香田澄あまり") && names.include?("マリオ")
      message << "#香田澄あまり誕生祭#{date.year} #香田澄あまり生誕祭#{date.year} #マリオ誕生祭#{date.year} #マリオ生誕祭#{date.year} #アマリオン合神祭#{date.year}"
      names.reject! { |name| %w(香田澄あまり マリオ).include?(name) }
    end

    names.each do |name|
      year = date.year
      case name
      when "らぁるる"
        year += 1000
      end

      message << " ##{name}誕生祭#{year}"
      message << " ##{name}生誕祭#{year}"
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
