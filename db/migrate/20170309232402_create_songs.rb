class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :play_url
      t.string :spotify_song_id
      t.integer :artist_id
      t.string :album_name
      t.timestamps
    end
  end
end
