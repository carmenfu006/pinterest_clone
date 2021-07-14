class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  def find_comment(id)
    return Comment.find(id)
  end

  after_create_commit do
    broadcast_replace_to "comment_#{self.likeable_id}_like_count", target: "comment_#{self.likeable_id}_like_count", locals: { user: self.user, pin: find_comment(self.likeable_id).pin, comment: find_comment(self.likeable_id)}
  end

  after_destroy_commit do
    broadcast_replace_to "comment_#{self.likeable_id}_like_count", target: "comment_#{self.likeable_id}_like_count", locals: { user: self.user, pin: find_comment(self.likeable_id).pin, comment: find_comment(self.likeable_id)}
  end

  # CANNOT HAVE MULTIPLE BROADCAST it will appear duplicate view
  # after_create_commit do
  #   broadcast_replace_to "user_#{user.id}_like", target: "user_#{user.id}_like", locals: { user: self.user, pin: find_comment(self.likeable_id).pin, comment: find_comment(self.likeable_id)}
  # end

  # after_destroy_commit do
  #   broadcast_replace_to "user_#{user.id}_like", target: "user_#{user.id}_like", locals: { user: self.user, pin: find_comment(self.likeable_id).pin, comment: find_comment(self.likeable_id)}
  # end
end