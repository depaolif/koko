class Review < ApplicationRecord
  validates :song_score, inclusion: {:in => 1..5}
  belongs_to :account
  belongs_to :song
  has_many :votes
  has_many :friends, :class_name => 'Friend', :foreign_key => :account_id
  validate :validate_form_input

  def vote_sum
    self.votes.sum('score')
  end

  def calculate_weighted_score
    if self.votes.sum(:score) < 0 && self.song_score > 3
      self.weighted_score = 2.9
      self.save
    else
      self.weighted_score = self.song_score
      self.save
    end
  end


  private

  def validate_form_input
    if !self.content.scan(/[<>]/).empty?
      errors.add(:content, "Don't try to pull a fast one on us.")
    end
  end

end
