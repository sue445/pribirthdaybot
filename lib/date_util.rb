module DateUtil
  # Get date in JST
  # @param unixtime [Integer,nil]
  # @return [Date]
  # @note If nil is passed to unixtime, returns today's date in JST
  def self.jst_date(unixtime = nil)
    unixtime ||= Time.now.to_i
    Time.at(unixtime, in: "+09:00").to_date
  end
end
