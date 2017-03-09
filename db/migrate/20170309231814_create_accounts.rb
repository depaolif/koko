class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :user_name
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
