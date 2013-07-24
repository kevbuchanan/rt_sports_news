class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :title, presence: true

  def short_url
    self.url.split('/')[2]
  end
end
