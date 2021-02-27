class Bot
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
end
