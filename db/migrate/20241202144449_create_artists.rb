class CreateArtists < ActiveRecord::Migration[7.1]
  def change
    create_table :artists do |t|
      t.string :artist_display_name
      t.string :artist_nationality

      t.timestamps
    end
  end
end
