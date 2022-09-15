# frozen_string_literal: true

class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
  validates_associated :movie, :hall
  validates :start_time, :end_time, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
end
