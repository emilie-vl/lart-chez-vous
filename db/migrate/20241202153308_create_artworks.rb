class CreateArtworks < ActiveRecord::Migration[7.1]
  def change
    create_table :artworks do |t|
      t.string :title
      t.string :image_url
      t.float :price_by_day
      t.string :classification
      t.string :object_date
      t.string :dimensions
      t.references :artist, null: false, foreign_key: true
      t.references :owner, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
