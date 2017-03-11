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

  #account having voted on a review
  def voted?(review_id)
    binding.pry
    Vote.where(account_id: self.id).where(review_id: review_id)
  end

  ### Accounts you've upvoted alot

  ### Reviews_I_have_voted

end
