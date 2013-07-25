class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, class_name: "Postvote"
  validates :title, presence: true

  def short_url
    self.url.split('/')[2]
  end
end
