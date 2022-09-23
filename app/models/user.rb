# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validate :password_length
  enum role: { client: 0, manager: 1 }
  has_many :reservations
  def password_length
    errors.add(:password, :too_long, message: 'Password is too long') if password.nil? || password.bytesize > 72
  end
end
