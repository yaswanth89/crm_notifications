class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.date :at
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
