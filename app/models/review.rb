class Review < ApplicationRecord
  validates :song_score, inclusion: {:in => 1..5}
  belongs_to :account
  belongs_to :song
  has_many :votes
  has_many :friends, :class_name => 'Friend', :foreign_key => :account_id
  validate :validate_form_input


  private
  
  def vote_sum
    self.votes.sum('score')
  end

  def weighted_score
    if (self.votes.sum(:score).abs) == 0 && self.votes.count != 0
      (1/self.votes.count).to_f
    elsif self.votes.count == 0 && (self.votes.sum(:score).abs) == 0
      1
    else
    ((self.votes.sum(:score).abs)/self.votes.count).to_f
    end
  end

  def validate_form_input
    if !self.content.scan(/[<>]/).empty?
      errors.add(:content, "Don't try to pull a fast one on us.")
    end
  end

end
