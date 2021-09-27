require 'rails_helper'

RSpec.describe Taximeter, type: :model do
  it {should belong_to :company}

  it { should validate_presence_of :start_price}
  it { should validate_presence_of :km_price}
  it { should validate_presence_of :minute_price}
  it { should validate_presence_of :minimum_price}
  it { should validate_presence_of :time_from}
  it { should validate_presence_of :time_to}
  it { should validate_presence_of :days}
end
