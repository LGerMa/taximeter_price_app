class Taximeter < ApplicationRecord
  belongs_to :company

  include DateTimeValidation

  validates :start_price, :km_price, :minute_price,
            :minimum_price, :time_from, :time_to, :days, presence: true
  validates :start_price, :km_price, :minute_price,
            :minimum_price, numericality: true

  validate :time_to_less_than_time_from, if: :time_from? && :time_to?

  #save time_from and time_to in minutes, to be used in filter actions
  before_save :save_time_from_minutes, if: :time_from?
  before_save :save_time_to_minutes, if: :time_to?

  attr_accessor :total_calculated

  scope :search, -> (date = DateTime.now) {
    day = Date::ABBR_DAYNAMES[date.wday]
    time_start = (date.hour * 60) + date.min
    search_by_day(day).search_by_time(time_start).order(:time_from_minutes)
  }

  #day in ABBR_DAYNAMES
  scope :search_by_day, -> (day) {
    #day = Date::ABBR_DAYNAMES[date.wday]
    where("days LIKE ?", "%"+day+"%")
  }

  scope :search_by_time, -> (time) {
    where('time_from_minutes <= ? AND time_to_minutes >= ?', time, time )
  }

  def time_to_less_than_time_from
    if time_to < time_from
      errors.add(:time_to, "is less than time from")
    end
  end

  def time_to_formatted
    formatted_time(self.time_to)
  end

  def time_from_formatted
    formatted_time(self.time_from)
  end

  private

    def save_time_from_minutes
      self::time_from_minutes = time_in_min(self.time_from)
    end

    def save_time_to_minutes
      self::time_to_minutes = time_in_min(self.time_to)
    end
end
