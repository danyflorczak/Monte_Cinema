# frozen_string_literal: true

class Reservation < ApplicationRecord
  enum status: { created: 0, paid: 1, canceled: 2 }
  belongs_to :screening
  has_many :tickets, dependent: :destroy
end
