class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_task, only: [:new, :show, :destroy, :create]
    before_action :set_board, only: [:new, :show, :destroy, :create]

    def new
        @comment = @task.comments.build
        @comment.user_id = current_user.id
    end

    def create
        @comment = @task.comments.build(comment_params)
        @comment.user_id = current_user.id
        if @comment.save
          redirect_to board_path(@task.board_id), notice: 'コメントを追加'
        else
          flash.now[:error] = 'コメントを追加できませんでした'
          render :new
        end
     end

     def destroy
        comment = Comment.find(params[:id])
        comment.destroy!
        redirect_to board_task_path(@board,@task), notice: 'コメントが削除されました'
     end

    private
    def comment_params
          params.require(:comment).permit(:content)
    end

    def set_task
        @task = Task.find(params[:task_id])
    end

    def set_board
        @board = Board.find(params[:board_id])
    end

end