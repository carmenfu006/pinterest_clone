class Pin < ApplicationRecord
  belongs_to :board

  has_one_attached :image

  has_many :comments, dependent: :destroy

  delegate :user, to: :board

  validates :title, presence: true
  validates :image, presence: true

  # append will add the new pin at last which is ASC order
  # prepend will add the new pin at first which is DESC order

  after_create_commit { broadcast_prepend_to 'pins', target: "user_#{self.user.id}_pins" }
  after_update_commit { broadcast_replace_to 'pins'}
  after_destroy_commit { broadcast_remove_to 'pins'}
end