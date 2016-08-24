class User < ApplicationRecord
  devise :database_authenticatable, :registerable
  has_many :schedulings, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end
