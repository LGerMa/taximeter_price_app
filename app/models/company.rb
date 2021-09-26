class Company < ApplicationRecord
  has_many :taximeters

  validates :name, presence: true
end
