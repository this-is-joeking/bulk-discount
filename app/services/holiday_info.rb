require 'holiday_service.rb'

class HolidayInfo
  def initialize
    @holidays = HolidayService.new.get_holidays
  end

  def next_three
    next_three_holidays = @holidays.first(3)
    x = next_three_holidays.map do |holiday|
      holiday[:localName] + " " +  holiday[:date]
    end
  end
end