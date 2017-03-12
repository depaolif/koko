class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends do |t|
      t.integer :account_id
      t.integer :friend_id
      t.timestamps
    end
  end
end
