class PostsController < ApplicationController
  before_action :find_board, only: [:new, :create, :edit]
  before_action :authenticate_user!, [:show, :edit]

  def new
    @post = @board.posts.new
  end

  def create
    # 以看板角度發文
    @post = @board.posts.new(post_params)
    # @post.user = current_user

    # 以作者角度發文
    # @post = current_user.posts.new(post_params)
    # @post.board = @board

    if @post.save
      redirect_to @board, notice: "文章新增成功"
    else
      render :new
    end
  end

  def edit
    # @post = Post.find_by(id: params[:id], user: current_user)
    @post = current_user.posts.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :content).merge(user: current_user)
  end

  def find_board
    @board = Board.find(params[:board_id])
  end
end
