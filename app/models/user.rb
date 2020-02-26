class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  attr_accessor :current_password
  validates :password, presence: { if: :current_password }
  has_secure_password

  has_one_attached :profile_picture
  attribute :new_profile_picture
  attribute :remove_profile_picture, :boolean

  before_save do
    if new_profile_picture
      self.profile_picture = new_profile_picture
    elsif remove_profile_picture
      self.profile_picture.purge
    end
  end



  has_many :tweets, dependent: :destroy

  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverses_of_relationship, source: :user

  has_many :favorites, dependent: :destroy
  has_many :favorite_tweets, through: :favorites, source: :tweet

  has_many :comments, dependent: :destroy
  has_many :comment_tweets, through: :comments, source: :tweet

  has_many :alerts, dependent: :destroy

  def follow(other_user)
    if self != other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
      relationship = self.relationships.find_by(follow_id: other_user.id)
      other_user.alerts.create(relationship_id: relationship.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def feed_tweets
    Tweet.where(user_id: self.following_ids + [self.id])
  end

  def favorite(tweet)
      self.favorites.find_or_create_by(tweet_id: tweet.id)
      if self.id != tweet.user.id
        favorite = self.favorites.find_by(tweet_id: tweet.id)
        tweet.user.alerts.create(favorite_id: favorite.id)
      end
  end

  def quit_favorite(tweet)
    favorite = self.favorites.find_by(tweet_id: tweet.id)
    favorite.destroy if favorite
  end

  def favorite?(tweet)
    self.favorite_tweets.include?(tweet)
  end

end
