class CreateActiveUsers < ActiveRecord::Migration
  def change
    create_table :active_users do |t|
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
