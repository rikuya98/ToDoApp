class TasksController < ApplicationController

    def show
        # @board = Board.find(params[:id])
        # @tasks = @board.tasks
        # @board = Board.find(params[:id])
        # @tasks = Task.find(params[:id])
        @tasks = Task.find(params[:id])
    end

    def new
        board = Board.find(params[:board_id])
        @task = board.tasks.build
        @task.user_id = current_user.id
    end

    def create
        board = Board.find(params[:board_id])
        @task = board.tasks.build(task_params)
        @task.user_id = current_user.id

        if @task.save
            redirect_to board_path(board), notice: 'タスクを追加'
        else
            flash.now[:error] = 'タスクを追加できませんでした'
            render :new
        end
    end

    def edit
      @task = current_user.tasks.find(params[:id])
    end

    def update
        @task = current_user.tasks.find(params[:id])
        if @task.update(task_params)
          redirect_to board_task_path(@task), notice: '更新できました'
        else
            flash.now[error] = '更新できませんでした'
            render :edit
        end
    end


      def destroy
        task = current_user.tasks.find(params[:id])
        task.destroy!
        redirect_to board_path(task.board_id),notice: 'タスクが削除されました'
      end

    private
    def task_params
        params.require(:task).permit(:name, :description, :start_day, :end_day, :eyecatch)
    end
end
