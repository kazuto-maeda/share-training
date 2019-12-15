class Tweet < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true
  mount_uploader :image, ImageUploader
  
  has_many :trainings
  accepts_nested_attributes_for :trainings, allow_destroy: true

end