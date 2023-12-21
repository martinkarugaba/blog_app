class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :posts, foreign_key: 'author_id'
  has_many :comments
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  attribute :posts_counter, :integer, default: 0

  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end

  def delete_user_from_database
    destroy
  end

  enum role: %i[user admin moderator] # Add any roles you need

  def admin?
    role == 'admin'
  end
end
