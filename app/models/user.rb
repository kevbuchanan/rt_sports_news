class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  attr_accessor :password, :password_confirmation

  validates :name, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true, format: {with: /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/}
  validates :password, presence: true
  validates_confirmation_of :password
  before_save :hash_password

  def hash_password
    self.password_hash = BCrypt::Password.create(self.password)
  end

  def self.authenticate(name, password)
    user = User.find_by_name(name)
    if user && BCrypt::Password.new(user.password_hash) == password
      user
    else
      nil
    end
  end
end
