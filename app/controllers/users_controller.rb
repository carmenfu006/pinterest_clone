class UsersController < ApplicationController

  def show
    @board = Board.new
    @boards = current_user.boards
    @pins = current_user.pins.order("id DESC")
  end

end