class Pin < ApplicationRecord
  belongs_to :board

  has_one_attached :image

  delegate :user, to: :board

  validates :title, presence: true
end