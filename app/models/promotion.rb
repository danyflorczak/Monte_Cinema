class Promotion < ApplicationRecord
  validates :value, :description, presence: true
end