class Account < ApplicationRecord

  has_secure_password
  has_one :profile, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :songs, through: :reviews
  has_many :votes, through: :reviews

  #Account as recipient of upvotes
  def vote_total
    self.reviews.map{|review| review.vote_sum}.sum
  end

####################################################

  #account having voted on a review
  def voted?(review_id)
    !Vote.where(account_id: self.id).where(review_id: review_id).empty?
  end

  #the value of the vote you cast for a given review
  def voted_score(review_id)
    Vote.where(account_id: self.id).where(review_id: review_id).first.score
  end

  #returns the votes that you cast
  def votes_cast
    Vote.where(account_id: self.id)
  end

  ### Accounts you've upvoted
  def voted_accounts
    Account.joins(:votes).where(votes: {account_id: current_user.id})
  end

  def upvoted_accounts
    Account.joins(:votes).where(votes: {account_id: 13}).where(votes: {score: 1})
  end

  ### Reviews_I_have_voted

end
