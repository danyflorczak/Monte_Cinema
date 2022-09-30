# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { client: 0, manager: 1 }
  has_many :reservations
  validates :email, presence: true
  validates :email, uniqueness: true
end
