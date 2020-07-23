class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def new
  end

  def create
    # render html: params["title"]
    Board.create(title: params[:title], intro: params[:intro])
    render html: "OK"
  end
end
