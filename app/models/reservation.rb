# frozen_string_literal: true

class Reservation < ApplicationRecord
  enum status: { created: 0, paid: 1, canceled: 3 }
  belongs_to :screening
  belongs_to :user
  has_many :tickets, dependent: :destroy
end
