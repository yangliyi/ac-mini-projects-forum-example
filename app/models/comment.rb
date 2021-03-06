class Comment < ActiveRecord::Base
  validates_presence_of :content, :user_id, :post_id

  belongs_to :user
  belongs_to :post, :counter_cache => true

  delegate :email, :to => :user, :prefix => true, :allow_nil => true
end
