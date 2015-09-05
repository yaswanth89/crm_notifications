class AddMandOffToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mand_off, :integer, :default => 0
  end
end
