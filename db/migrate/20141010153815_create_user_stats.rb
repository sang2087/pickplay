class CreateUserStats < ActiveRecord::Migration
  def change
    create_table :user_stats do |t|
      t.integer :user_id
      t.float :stat0
      t.float :stat1
      t.float :stat2
      t.float :stat3
      t.float :stat4

      t.timestamps
    end
  end
end
