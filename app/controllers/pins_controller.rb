class PinsController < ApplicationController

  def new
    @pin = Pin.new
    @boards = current_user.boards
  end
  
  def create
    pin = Pin.create(pin_params)
    @boards = current_user.boards

    respond_to do |format|
      if pin.save
        @flash = turbo_flash(notice: 'Pin was successfully created.')
        format.turbo_stream do
          render turbo_stream: @flash + turbo_stream.prepend(
            :"user_#{current_user.id}_pins",
            partial: "pins/pin", locals: { pin: pin }
          )
        end
        format.html { redirect_to user_path(current_user), notice: 'Pin was successfully created.' }
      else
        @flash = turbo_flash(alert: 'There was an error. Please try again.')
        format.turbo_stream { render turbo_stream: @flash + turbo_stream.replace(pin, partial: 'pins/form', locals: { pin: pin, boards: @boards })}
      end
    end
  end

  def show
    @pin = Pin.find(params[:id])
    @boards = current_user.boards
    @comment = Comment.new
    @comments = @pin.comments.order("id ASC")
    @like = Like.new
  end

  def edit
    @pin = Pin.find(params[:id])
    @boards = current_user.boards
  end

  def update
    pin = Pin.find(params[:id])
    pin.update(pin_params)
    @boards = current_user.boards

    respond_to do |format|
      if pin.save
        @flash = turbo_flash(notice: 'Pin was successfully updated.')
        format.turbo_stream do
          render turbo_stream: @flash + turbo_stream.replace(
            :"pin_#{pin.id}",
            partial: "pins/show", locals: { pin: pin }
          )
        end
        format.html { redirect_to pin_path(pin), notice: 'Pin was successfully updated.' }
      else
        format.html { redirect_to pin_path(pin), alert: 'There was an error. Please try again.' }
        @flash = turbo_flash(alert: 'There was an error. Please try again.')
        format.turbo_stream { render turbo_stream: @flash + turbo_stream.replace(pin, partial: 'pins/form', locals: { pin: pin, boards: @boards })}
      end
    end
  end

  def destroy
    pin = Pin.find(params[:id])

    respond_to do |format|
      if pin.destroy
        # format.turbo_stream { render turbo_stream: turbo_stream.remove(pin) }
        format.html { redirect_to user_path(current_user), notice: 'Pin was successfully destroyed.' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(pin, partial: 'pins/pin', locals: { pin: pin })}
      end
    end
  end

  private
    def pin_params
      params.require(:pin).permit(:board_id, :title, :about, :image)
    end
end