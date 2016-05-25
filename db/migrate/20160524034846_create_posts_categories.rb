class CreatePostsCategories < ActiveRecord::Migration
  def change
    create_table :posts_categories do |t|
      t.integer :post_id, :index => true
      t.integer :category_id, :index => true

      t.timestamps null: false
    end
  end
end
