class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :file_article
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
