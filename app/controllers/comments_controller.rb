class CommentsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_pin, only: [:new, :create, :edit, :update, :destroy, :like, :unlike]
  before_action :set_comment, except: [:new, :create, :like, :unlike]
  
  def new
    @comment = Comment.new
  end

  def create
    @comment = @pin.comments.create(comment_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @comment.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(
            :"pin_#{@pin.id}_comments",
            partial: "comments/comment", locals: { comment: @comment, pin: @pin, user: current_user }
          )
        end
        # to have it redirect so that it will render a new form instead of having to use stimulus to clear it
        format.html { redirect_to pin_path(@pin) }
        # mailer
        # CommentMailer.new_comment_notification(@pin, @comment).deliver_now
      else
        # comment here will be Comment.new because is now invalid
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@comment), partial: 'comments/form', locals: { comment: @comment, pin: @pin }) }
        format.html { redirect_to pin_path(@pin), notice: 'There was an error. Please try again.' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            :"comment_#{@comment.id}",
            partial: "comments/comment", locals: { comment: @comment, pin: @pin, user: current_user }
          )
        end
        format.html { redirect_to pin_path(@pin) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@comment), partial: 'comments/form', locals: { comment: @comment, pin: @pin }) }
        format.html { redirect_to pin_path(@pin), notice: 'There was an error. Please try again.' }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      # format.turbo_stream { }
      @flash = turbo_flash(notice: 'Comment was successfully destroyed')
      format.turbo_stream { render turbo_stream: @flash + turbo_stream.remove(@comment) }
      format.html { redirect_to pin_path(@pin) }
    end
  end

  def like
    @comment = Comment.find(params[:comment_id])
    @like = @comment.likes.create(user_id: current_user.id)

    redirect_to pin_path(@pin)
    # render turbo_stream: turbo_stream.replace("comment_#{@comment.id}_like_count", partial: 'likes/like', locals: { comment: comment })
  end

  def unlike
    @comment = Comment.find(params[:comment_id])
    @like = @comment.liked(current_user)
    @like.destroy
    redirect_to pin_path(@pin)
    # render turbo_stream: turbo_stream.replace("comment_#{comment.id}_like_count", partial: 'likes/like', locals: { comment: comment })
  end

  private
    def set_pin
      @pin = Pin.find(params[:pin_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end