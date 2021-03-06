class BoardsController < ApplicationController
  before_action :find_board, only: [:show, :edit, :update, :destroy, :favorite, :hide]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @boards = Board.normal.page(params[:page])
  end

  def show
    @post = @board.posts.includes(:user)
  end

  def favorite
    @board = Board.find(params[:id])
    current_user.toggle_favorite_board(@board)

    respond_to do |format|
      format.html { redirect_to favorites_path, notice: "OK!" }
      format.json { render json: { status: @board.favorited_by?(current_user) } }
    end
    # redirect_to favorites_path, notice: "OK!"
  end

  def new
    @board = Board.new
    authorize @board, :new?
  end

  def create
    @board = Board.new(board_params)
    @board.users << current_user
    authorize @board, :create?
    if @board.save
      # flash[:notice] = "新增成功"
      # redirect_to boards_path
      redirect_to boards_path, notice: "新增成功"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @board.update(board_params)
      redirect_to boards_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    @board.destroy
    redirect_to boards_path, notice: "刪除成功"
  end

  def hide
    @board.hide! if @board.may_hide?
    redirect_to boards_path, notice: "看板已隱藏"
  end

  private

  def find_board
    @board = Board.normal.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :intro)
  end
end
