class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.text :bio
      t.string :interests
      t.integer :account_id

      t.timestamps
    end
  end
end
