class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def new
    @board = Board.new
  end

  def create
    
    @board = Board.new(board_params)
   
    if @board.save
      # flash[:notice] = "新增成功"
      # redirect_to boards_path 
      redirect_to boards_path, notice: "新增成功"
    else

    end

  end

  private
  def board_params
    params.require(:board).permit(:title, :intro)
  end
end
