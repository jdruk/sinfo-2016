class RemoveTypeToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :type, :integer, null: false, default: 0
  end
end
