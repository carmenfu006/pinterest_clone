class Board < ApplicationRecord
  belongs_to :user

  has_many :pins

  validates :name, presence: true

  after_create_commit { broadcast_append_to 'boards'}
end