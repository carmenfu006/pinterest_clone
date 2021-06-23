class Board < ApplicationRecord
  belongs_to :user

  has_many :pins, dependent: :destroy

  validates :name, presence: true

  after_create_commit { broadcast_append_to 'boards'}
  after_update_commit { broadcast_replace_to 'boards'}
  after_destroy_commit { broadcast_remove_to 'boards'}
end