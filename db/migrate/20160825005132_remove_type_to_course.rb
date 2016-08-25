class RemoveTypeToCourse < ActiveRecord::Migration
  def change
    remove_column :courses, :type, :integer
  end
end
