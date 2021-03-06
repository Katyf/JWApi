class Post < ActiveRecord::Base
  has_many :images
  has_one :featured_image
  has_one :thumbnail
  has_and_belongs_to_many :categories
  belongs_to :user
  validates :title, :body, presence: true
end