class Category < ActiveRecord::Base
  validates_presence_of :name

  has_many :posts_categories
  has_many :posts, :through => :posts_categories
end
