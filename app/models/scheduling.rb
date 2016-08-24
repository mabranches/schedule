class Scheduling < ApplicationRecord
  belongs_to :user
  validates :day, presence: true
  validates :hour, presence: true, uniqueness: {scope: [:day]}
  validates :user, presence: true
end
