class Post < ActiveRecord::Base
  validates_presence_of :title, :content, :user_id

  belongs_to :user
  has_many :comments, -> { order(:updated_at => :desc) }
  has_many :posts_categories
  has_many :categories, :through => :posts_categories

  delegate :email, :to => :user, :prefix => true, :allow_nil => true
end
