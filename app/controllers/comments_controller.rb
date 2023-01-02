class CommentsController < ApplicationController
    def new
        # task = Task.find(params[:task_id])
        # board = task.board_id
        @task = Task.find(params[:task_id])
        @comment = @task.comments.build
        @comment.user_id = current_user.id
        @board = Board.find(params[:board_id])
    end

    def create
        @task = Task.find(params[:task_id])
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
        board = Board.find(params[:board_id])
        task = Task.find(params[:task_id])
        comment = Comment.find(params[:id])
        comment.destroy!
          redirect_to board_task_path(board,task), notice: 'コメントが削除されました'
    end

      private
      def comment_params
          params.require(:comment).permit(:content)
      end

end