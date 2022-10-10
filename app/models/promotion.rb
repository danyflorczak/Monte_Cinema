# frozen_string_literal: true

class Promotion < ApplicationRecord
  validates :value, :description, presence: true
  belongs_to :user
end
