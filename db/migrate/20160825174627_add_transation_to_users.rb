class AddTransationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :transation, :string
  end
end
