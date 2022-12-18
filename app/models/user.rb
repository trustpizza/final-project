class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Friend Request Modeling

  has_many :sent_friend_requests, foreign_key: :sender_id, class_name: 'FriendRequest', dependent: :destroy
  has_many :received_friend_requests, foreign_key: :receiver_id, class_name: 'FriendRequest', dependent: :destroy

  # Friends modeling

  has_many :began_friendships, foreign_key: :user_id, class_name: "Friendship", dependent: :destroy
  has_many :accepted_friendships, foreign_key: :friend_id, class_name: "Friendship", dependent: :destroy
  has_many :began_friends, through: :began_friendships, source: :friend, dependent: :destroy
  has_many :accepted_friends, through: :accepted_friendships, source: :user, dependent: :destroy

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :likes, dependent: :destroy 
  has_many :liked_posts, through: :likes, source: :post

  has_many :comments,foreign_key: :commenter_id, dependent: :destroy

  def friends
    (began_friends + accepted_friends).uniq
  end
end
