class LikesController < ApplicationController
  def create
    comment = Comment.find(params[:like][:likeable])
    like = comment.likes.create(user_id: current_user.id)

    if like.save
      redirect_to pin_path(comment.pin), notice: 'You have liked the comment.'
    else
      redirect_to pin_path(comment.pin), alert: 'There was an error. Please try again.'
    end
  end

  def destroy
    like = Like.find(params[:id])
    comment = like.likeable
    like.destroy
    redirect_to pin_path(comment.pin)
  end
end