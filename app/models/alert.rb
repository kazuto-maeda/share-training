class Alert < ApplicationRecord
  belongs_to :user
  belongs_to :relationship, optional: true
  belongs_to :favorite, optional: true
  belongs_to :comment, optional: true
end
