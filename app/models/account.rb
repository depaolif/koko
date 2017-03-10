class Account < ApplicationRecord

  has_secure_password
  has_one :profile, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :songs, through: :reviews
  has_many :votes, through: :reviews
end
