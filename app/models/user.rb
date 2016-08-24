class User < ApplicationRecord
  devise :database_authenticatable, :registerable
  has_many :Schedulings
end
