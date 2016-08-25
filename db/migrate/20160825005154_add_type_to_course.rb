class AddTypeToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :type_day, :integer
  end
end
