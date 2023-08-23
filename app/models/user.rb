# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: [:google_oauth2]
  enum role: { client: 0, manager: 1 }
  has_many :reservations
  has_many :promotions
  validates :email, presence: true
  validates :email, uniqueness: true

  validate do
    errors.add(:base, "Password is too long") if password.present? && (password.bytesize > 72)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uuid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[8, 20]
      user.full_name = auth.info.full_name
      user.avatar_url = auth.info.image
    end
  end
end
