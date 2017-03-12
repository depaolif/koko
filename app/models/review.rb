class Review < ApplicationRecord
  belongs_to :account
  belongs_to :song
  has_many :votes
  has_many :friends, :class_name => 'Friend', :foreign_key => :account_id

  def vote_sum
    self.votes.sum('score')
  end
end
