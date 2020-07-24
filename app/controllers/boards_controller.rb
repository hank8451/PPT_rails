class BoardsController < ApplicationController

  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
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
      render :new
    end
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    
    if @board.update(board_params)
      redirect_to boards_path, notice: "更新成功"
    else
      render :edit
    end
  end

 

  private
  def board_params
    params.require(:board).permit(:title, :intro)
  end
end
