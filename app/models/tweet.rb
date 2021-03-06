class Tweet < ApplicationRecord
  belongs_to :user

  validates :content, presence: true

  has_many :trainings, dependent: :destroy
  accepts_nested_attributes_for :trainings, allow_destroy: true, reject_if: :all_blank

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  has_many :comments, dependent: :destroy
  has_many :comment_users, through: :comments, source: :user

end
