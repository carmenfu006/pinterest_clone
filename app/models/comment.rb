class Comment < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :user
  belongs_to :pin

  validates :body, presence: true

  after_create_commit do
    broadcast_append_later_to [pin, :comments], target: "#{dom_id(pin)}_comments"
  end

  after_destroy_commit do
    broadcast_remove_to [pin, :comments]
  end
end