class CreateGameMovies < ActiveRecord::Migration
  def change
    create_table :game_movies do |t|
      t.integer :game_id
      t.string :movie_url

      t.timestamps
    end
  end
end
