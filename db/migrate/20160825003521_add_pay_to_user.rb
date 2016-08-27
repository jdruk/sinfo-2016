class AddPayToUser < ActiveRecord::Migration
  def change
    add_column :users, :pay, :integer, null: false, default: 0
  end
end
