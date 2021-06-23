class BoardsController < ApplicationController

  def new
    @board = Board.new
  end

  def create
    board = current_user.boards.create(board_params)

    if board.save
      redirect_to user_path(current_user), notice: 'Board is successfully created.'
    else
      redirect_to user_path(current_user), notice: 'There was an error. Please try again.'
    end
  end

  def show
    @board = Board.find(params[:id])
  end

  private
    def board_params
      params.require(:board).permit(:name)
    end
end