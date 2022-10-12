# frozen_string_literal: true

class Reservation < ApplicationRecord
  enum status: { booked: 0, confirmed: 1, canceled: 2 }
  belongs_to :screening
  belongs_to :user, optional: true
  has_one :hall, through: :screening
  has_one :movie, through: :screening
  has_many :tickets, dependent: :destroy
  validates :email, presence: true
end
