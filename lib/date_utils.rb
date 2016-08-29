module DateUtils
  def self.this_monday
    Time.zone.today.beginning_of_week
  end

  def self.this_friday
    this_monday + 4
  end
end
