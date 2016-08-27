class AddPayToCourseUsers < ActiveRecord::Migration
  def change
    add_column :course_users, :pay, :integer, null: false, default: 0
  end
end
