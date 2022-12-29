class BoardsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @boards = Board.all
  end

  def show
    @board =Board.find(params[:id])
    @tasks = @board.tasks
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
    redirect_to board_path(@board), notice: '保存できました'
    else
      flash.now[:error] = '保存できませんでした'
      render :new
    end
  end

    def edit
      @board = current_user.boards.find(params[:id])
    end

    def update
      @board = current_user.boards.find(params[:id])
      if @board.update(board_params)
        redirect_to board_path(@board), notice: '更新できました'
      else
          flash.now[error] = '更新できませんでした'
          render :edit
      end
    end

    def destroy
      board = Board.find(params[:id])
      board.destroy!
      redirect_to boards_path, notice: 'ボードが削除されました'
    end

  private
  def board_params
  params.require(:board).permit(:name, :description)
  end
end
