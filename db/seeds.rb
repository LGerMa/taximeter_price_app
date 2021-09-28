# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

def minute_hours(minutes)
  hours = minutes / 60
  min = minutes % 60
  hours = hours < 10 ? '0'+hours.to_s : hours.to_s
  min = min < 10 ? '0'+min.to_s : min.to_s
  hours+":"+min
end

def random_minutes(from = 0)
  rand(from...1440)
end

def range_times(from = 0, extra = 0)
  min = random_minutes(from)
  max = extra == 0 ? random_minutes : min + extra
  n = 0
  while max < min
    if n > 5
      max = min
      break
    end
    max = extra == 0 ? random_minutes : min + extra
    n+=1
  end
  {
    :min => minute_hours(min),
    :max => minute_hours(max)
  }
end

def random_days
  used = []
  day_used = []
  rand(1...5).times do
    day = rand(0...6)
    while used.include? day
      day = rand(0...6)
    end
    day_used.push(Date::ABBR_DAYNAMES[day])
    used.push(day)
  end
  day_used.join(',')
end

rand(3...7).times do
  Company.create!({
                   name: Faker::Company.name
                 })
end

rand(15...25).times do
  try_to_insert = true
  while try_to_insert do
    days = random_days
    time = range_times(360, rand(0...120))
    c = Company.all.sample
    t=c.taximeters.new({
                         start_price: rand(5.0...15.0).round(2),
                         km_price: rand(1.0...5.0).round(2),
                         minute_price: rand(0.0...3.0).round(2) ,
                         minimum_price: rand(5.0...10.0).round(2) ,
                         time_from: time[:min],
                         time_to: time[:max],
                         days: days
                       })
    if t.save
      try_to_insert = false
    end
  end

end