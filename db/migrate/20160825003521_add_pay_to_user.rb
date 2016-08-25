class AddPayToUser < ActiveRecord::Migration
  def change
    add_column :users, :pay, :integer
  end
end
