class Artist < ApplicationRecord
  has_many :songs
  has_many :reviews, through: :songs

end
