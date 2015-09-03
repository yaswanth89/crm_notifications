class AddAtToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :at, :timestamp
  end
end
