class Song < ApplicationRecord
  has_many :reviews
  has_many :accounts, through: :reviews
end
