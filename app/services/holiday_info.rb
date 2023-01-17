require 'holiday_service.rb'

class HolidayInfo
  def initialize
    @holidays = HolidayService.new.get_holidays
  end

  def next_three
    @holidays.first(3).map do |holiday|
      holiday[:localName] + " " +  holiday[:date]
    end
  end
end