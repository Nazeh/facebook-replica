# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :friendships, dependent: :destroy

  has_many :friends,
           -> { where friendships: { status: 2 } },
           through: :friendships

  has_many :pending_friends,
           -> { where friendships: { status: 0 } },
           through: :friendships,
           source: :friend

  has_many :requested_friends,
           -> { where friendships: { status: 1 } },
           through: :friendships,
           source: :friend

  # user data

  def full_name
    "#{first_name} #{last_name}"
  end

  # OmniAuth

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      full_name = auth.info.name.split
      user.first_name = full_name.first
      user.last_name = full_name.last
      user.profile_image = auth.info.image
    end
  end

  # Friendships methods

  def strangers
    User.all - [self] - friends - pending_friends - requested_friends
  end

  def friend_request(friend)
    friendships.create(friend: friend, status: 0)
    friend.friendships.create(friend: self, status: 1)
  end

  def accept_request(friend)
    relations(friend).each { |friendship| friendship.update(status: 2) }
  end

  def relations(friend)
    Friendship.where(user: self, friend: friend) + Friendship.where(user: friend, friend: self)
  end

  def friends_with?(friend)
    Friendship.where(user: self, friend: friend, status: 2).any?
  end

  def decline_request(friend)
    relations(friend).each(&:destroy)
  end

  alias remove_friend decline_request

  # Feed methods

  def feed
    Post.where(user: (friends + [self]))
  end

  # Notifications methods

  def unseen_notifs
    notifications - (@seen_notifs || seen_notifs)
  end

  def seen_notifs
    @seen_notifs ||= []
    @seen_notifs += unseen_notifs.select(&:seen)
  end

  def see_all_notifs
    unseen_notifs.each { |notification| notification.update(seen: true) }
  end

  # callbacks

  def on_friendship_created(friendship)
    notifications.create(notifiable: friendship) unless friendship.status == 'requested'
  end

  def on_friendship_accepted(friendship)
    notifications.create(notifiable: friendship)
  end
end
