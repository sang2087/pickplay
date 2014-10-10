class CreateUserStats < ActiveRecord::Migration
  def change
    create_table :user_stats do |t|
      t.integer :stat0
      t.integer :stat1
      t.integer :stat2
      t.integer :stat3
      t.integer :stat4

      t.timestamps
    end
  end
end
