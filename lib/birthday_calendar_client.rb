require "open-uri"
require "yaml"

class BirthdayCalendarClient
  ALL_SERIES = %w(king_of_prism pretty_rhythm prichan pripara)

  # @return [Array<Hash>]
  def all_characters
    ALL_SERIES.each_with_object([]) do |series, characters|
      hash = fetch_config(series)
      characters.push(*hash["characters"])
    end
  end

  private

  # @return [Hash]
  def fetch_config(series)
    content = URI.parse("https://raw.githubusercontent.com/sue445/pretty-all-friends-birthday-calendar/master/config/#{series}.yml").read
    YAML.load(content)
  end
end
