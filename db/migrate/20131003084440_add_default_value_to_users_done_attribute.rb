class AddDefaultValueToUsersDoneAttribute < ActiveRecord::Migration
  def up
    change_column :users, :done, :boolean, default: false
  end
  def down
    change_column :users, :done, :boolean, default: nil
  end
end
