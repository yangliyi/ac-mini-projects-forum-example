class Post < ActiveRecord::Base
  validates_presence_of :title, :content, :user_id

  belongs_to :user
  has_many :comments, -> { order(:id => :desc) }

  delegate :email, :to => :user, :prefix => true, :allow_nil => true
end
