class Hall < ApplicationRecord
    has_many :screenings
    has_many :movies, through: :screenings
    validates :name, :capacity, presence: true
    validates :capacity, numericality: {only_integer: true, greater_than: 0 }
    validates :name, uniqueness: true
end
