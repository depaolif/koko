class Review < ApplicationRecord
  belongs_to :account
  belongs_to :song
  has_many :votes
end
