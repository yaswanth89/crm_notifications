class ChangeDefaultValueSomeColumnToUsers < ActiveRecord::Migration
  def change
    change_column :users, :some_column, :integer, :default => 1
  end
end
