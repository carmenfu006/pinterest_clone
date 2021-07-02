class CommentMailer < ApplicationMailer
  def new_comment_notification(pin, comment)
    @pin = pin
    @comment = comment
    @user = @pin.user

    mail(to: @user.email, subject: "New comment notification")
  end
end