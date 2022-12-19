class Post < ApplicationRecord
  validates :body, presence: true, length: { maximum: 300 }
  validates :title, presence: true

  belongs_to :author, class_name: "User"

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  scope :ordered, -> { order(id: :desc) }

  def time_format
    created_at.strftime("%b %-d, %Y")
  end

  def liked_by?(user)
    likes.any? { |like| like.user == user }
  end

  def find_like(user)
    likes.find_by(user: user)
  end
end
