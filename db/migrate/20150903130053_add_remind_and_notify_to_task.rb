class AddRemindAndNotifyToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :remind, :boolean, :default => true
    add_column :tasks, :notify, :boolean, :default => true
  end
end
