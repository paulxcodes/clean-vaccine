class Reservation < ApplicationRecord
  belongs_to :vaccine
  belongs_to :user
  validates :status, inclusion: { in: ['Pending', 'Confirmed', 'Cancelled'] }
end
