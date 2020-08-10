class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    if @comment.save
      # views/comments/creat.js.erb（祕技嘻嘻）
      redirect_to @post
    else
      redirect_to @post
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user: current_user)
  end
end
