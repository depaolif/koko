class UpvotesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'upvotes'
  end
end
