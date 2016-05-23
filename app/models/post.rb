class Post < ActiveRecord::Base
  validates_presence_of :title, :content, :user_id
  belongs_to :user

  delegate :email, :to => :user, :prefix => true, :allow_nil => true
end
