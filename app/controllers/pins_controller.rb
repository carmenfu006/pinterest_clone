class PinsController < ApplicationController

  def new
    @pin = Pin.new
    @boards = current_user.boards
  end
  
  def create
    pin = Pin.create(pin_params)

    if pin.save
      redirect_to pin_path(pin), notice: 'Pin was successfully created.'
    else
      render :new
    end
  end

  def show
    @pin = Pin.find(params[:id])
  end

  private
    def pin_params
      params.require(:pin).permit(:board_id, :title, :about, :image)
    end
end