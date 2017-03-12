class Friend < ApplicationRecord
  belongs_to :account, :class_name => 'Account', :foreign_key => :account_id
  belongs_to :friend, :class_name => 'Account', :foreign_key => :friend_id
end
