module DateTimeValidation
  extend ActiveSupport::Concern

  def formatted_time(time = Time.now)
    time.strftime('%H:%M %p')
  end

  def get_date_abbr(date = Date.current)
    Date::ABBR_DAYNAMES[date.wday]
  end

  def time_in_min(time = Time.now)
    (time.hour * 60) + time.min
  end
end