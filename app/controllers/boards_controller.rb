class BoardsController < ApplicationController

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.create(board_params)
    @boards = current_user.boards
    @pin = Pin.new

    respond_to do |format|
      if @board.save
        @flash = turbo_flash(notice: 'Board was successfully created.')
        format.turbo_stream
        # format.turbo_stream do
        #   render turbo_stream: turbo_stream.append(
        #     "user_#{current_user.id}_boards",
        #     partial: "boards/board", locals: { board: @board }
        #   )
        # end
        # format.turbo_stream do
        #   render turbo_stream: turbo_stream.replace(
        #     "new_pin",
        #     partial: "pins/form", locals: { boards: current_user.boards, pin: Pin.new }
        #   )
        # end
        # format.html { redirect_to user_path(current_user), notice: 'Board was successfully created.' }
      else
        @flash = turbo_flash(alert: 'There was an error. Please try again.')
        format.html { redirect_to user_path(current_user), notice: 'There was an error. Please try again.' }
        format.turbo_stream { render turbo_stream: @flash + turbo_stream.replace(@board, partial: 'boards/form', locals: { board: @board })}
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
    @board = Board.find(params[:id])
    @board.update(board_params)

    respond_to do |format|
      if @board.save
        @flash = turbo_flash(notice: 'Board was successfully updated.')
        format.turbo_stream
        # format.turbo_stream do
        #   render turbo_stream: turbo_stream.replace(
        #     :"board_#{board.id}",
        #     partial: "boards/board", locals: { board: board }
        #   )
        # end
        # format.html { redirect_to user_path(current_user), notice: 'Board was successfully updated.' }
      else
        @flash = turbo_flash(alert: 'There was an error. Please try again.')
        format.turbo_stream { render turbo_stream: @flash + turbo_stream.replace(@board, partial: 'boards/form', locals: { board: @board })}
        # format.html { redirect_to user_path(current_user), notice: 'There was an error. Please try again.' }
      end
    end
  end

  def destroy
    @board = Board.find(params[:id])
    
    respond_to do |format|
      if @board.destroy
        # format.turbo_stream { render turbo_stream: turbo_stream.remove(@board) }
        # format.turbo_stream { }
        format.html { redirect_to user_path(current_user), notice: 'Board was successfully destroyed.' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@board, partial: 'boards/board', locals: { board: @board })}
      end
    end
  end

  private
    def board_params
      params.require(:board).permit(:name)
    end
end