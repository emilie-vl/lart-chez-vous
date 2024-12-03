class AddHighlightedToArtworks < ActiveRecord::Migration[7.1]
  def change
    add_column :artworks, :highlighted, :boolean, default: false
  end
end
