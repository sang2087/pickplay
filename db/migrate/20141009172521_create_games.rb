class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.attachment :image
      t.string :genre_ids
      t.string :platform_ids

      t.timestamps
    end
  end
end
