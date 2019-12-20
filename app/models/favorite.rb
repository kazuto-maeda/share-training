class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  
  has_many :alert, dependent: :destroy
  
  validates :user_id, presence: true
  validates :tweet_id, presence: true
  
end
