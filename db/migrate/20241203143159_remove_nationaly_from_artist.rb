class RemoveNationalyFromArtist < ActiveRecord::Migration[7.1]
  def change
    remove_column :artists, :artist_nationality, :string
  end
end
