class CreateGameInfos < ActiveRecord::Migration
  def change
    create_table :game_infos do |t|
      t.integer :game_id
      t.attachment :image
      t.string :maker
      t.string :distribute
      t.string :date
      t.string :user_class
      t.string :movie
      t.text :content

      t.timestamps
    end
  end
end
