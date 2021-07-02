class CommentsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_pin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_comment, except: [:new, :create]
  
  def new
    @comment = Comment.new
  end

  def create
    @comment = @pin.comments.create(comment_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @comment.save
        # to have it redirect so that it will render a new form instead of having to use stimulus to clear it
        format.html { redirect_to pin_path(@pin) }
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
      format.turbo_stream { }
      format.html { redirect_to pin_path(@pin) }
    end
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