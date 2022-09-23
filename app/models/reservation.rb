# frozen_string_literal: true

class Reservation < ApplicationRecord
  enum status: { created: 0, paid: 1, canceled: 2 }
  belongs_to :screening
  belongs_to :user
  has_one :hall, through: :screening
  has_one :movie, through: :screening
  has_many :tickets, dependent: :destroy
end
