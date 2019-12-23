class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  
  has_many :alerts, dependent: :destroy
  
  validates :content, presence: true
end
