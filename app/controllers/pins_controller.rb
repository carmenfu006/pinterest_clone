class PinsController < ApplicationController

  def new
    @pin = Pin.new
    @boards = current_user.boards
  end
  
  def create
    pin = Pin.create(pin_params)

    respond_to do |format|
      if pin.save
        format.html { redirect_to user_path(current_user), notice: 'Pin was successfully created.' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(pin, partial: 'pins/form', locals: { pin: pin })}
      end
    end
  end

  def show
    @pin = Pin.find(params[:id])
  end

  def edit
    @pin = Pin.find(params[:id])
    @boards = @pin.user.boards
  end

  def update
    pin = Pin.find(params[:id])
    pin.update(pin_params)

    if pin.save
      redirect_to pin_path(pin), notice: 'Pin was successfully updated.'
    else
      redirect_to pin_path(pin), alert: 'There was an error. Please try again.'
    end
  end

  def destroy
    pin = Pin.find(params[:id])

    respond_to do |format|
      if pin.destroy
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