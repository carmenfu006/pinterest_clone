class Pin < ApplicationRecord
  belongs_to :board

  has_one_attached :image

  delegate :user, to: :board

  validates :title, presence: true

  after_create_commit { broadcast_append_to 'pins'}
  after_destroy_commit { broadcast_remove_to 'pins'}
end