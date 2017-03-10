class Account < ApplicationRecord

  has_secure_password
  has_one :profile, dependent: :destroy
  has_many :reviews
  has_many :songs, through: :reviews
end
