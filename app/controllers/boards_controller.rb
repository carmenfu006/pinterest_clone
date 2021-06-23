class BoardsController < ApplicationController

  def new
    @board = Board.new
  end

  def create
    board = current_user.boards.create(board_params)

    respond_to do |format|
      if board.save
        format.html { redirect_to user_path(current_user), notice: 'Board was successfully created.' }
      else
        # redirect_to user_path(current_user), notice: 'There was an error. Please try again.'
        format.turbo_stream { render turbo_stream: turbo_stream.replace(board, partial: 'boards/form', locals: { board: board })}
      end
    end
  end

  def show
    @board = Board.find(params[:id])
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    board = Board.find(params[:id])
    board.update(board_params)

    if board.save
      redirect_to user_path(current_user), notice: 'Board was successfully updated.'
    else
      redirect_to user_path(current_user), notice: 'There was an error. Please try again.'
    end
  end

  def destroy
    board = Board.find(params[:id])
    
    respond_to do |format|
      if board.destroy
        format.html { redirect_to user_path(current_user), notice: 'Board was successfully destroyed.' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(board, partial: 'boards/board', locals: { board: board })}
      end
    end
  end

  private
    def board_params
      params.require(:board).permit(:name)
    end
end