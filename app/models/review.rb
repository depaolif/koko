class Review < ApplicationRecord
  belongs_to :account
  belongs_to :song
  has_many :votes

  def vote_sum
    self.votes.sum('score')
  end
end
