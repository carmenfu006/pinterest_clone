class Comment < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :user
  belongs_to :pin

  has_many :likes, as: :likeable

  validates :body, presence: true

  # after_create_commit do
  #   broadcast_append_later_to [pin, :comments], target: "#{dom_id(pin)}_comments", locals: { user: self.user }
  # end

  # after_destroy_commit do
  #   broadcast_remove_to [pin, :comments]
  # end

  def liked(user)
    like = likes.find_by_user_id(user.id)
    return like if like.present?
  end

  after_create_commit do
     broadcast_append_to pin, locals: { user: self.user, pin: pin }
  end

  after_update_commit do
    broadcast_replace_to pin, locals: { user: self.user, pin: pin }
  end

  after_destroy_commit { broadcast_remove_to pin }
end