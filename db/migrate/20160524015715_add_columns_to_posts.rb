class AddColumnsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :comments_count, :integer, :default => 0
    add_column :posts, :last_commented_at, :datetime
  end
end
