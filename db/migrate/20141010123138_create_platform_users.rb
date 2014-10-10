class CreatePlatformUsers < ActiveRecord::Migration
  def change
    create_table :platform_users do |t|
      t.integer :platform_id
      t.integer :user_id

      t.timestamps
    end
  end
end
