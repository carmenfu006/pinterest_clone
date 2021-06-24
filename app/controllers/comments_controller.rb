class CommentsController < ApplicationController
  include ActionView::RecordIdentifier
  
  def new
    @pin = Pin.find(params[:pin_id])
    @comment = Comment.new
  end

  def create
    pin = Pin.find(params[:pin_id])
    comment = pin.comments.create(comment_params.merge(user_id: current_user.id))

    respond_to do |format|
      if comment.save
        format.html { redirect_to pin_path(pin), notice: 'Comment was successfully created.' }
      else
        # comment here will be Comment.new because is now invalid
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id_for_records(pin, comment), partial: 'comments/form', locals: { comment: comment, pin: pin }) }
        format.html { redirect_to pin_path(pin), notice: 'There was an error. Please try again.' }
      end
    end
  end

  def destroy
    pin = Pin.find(params[:pin_id])
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to pin_path(pin), notice: 'Comment was successfully destroy.'
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end