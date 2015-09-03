class AddSomeColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :some_column, :integer, :default => 0, :null => false, :unique => true
  end
end
