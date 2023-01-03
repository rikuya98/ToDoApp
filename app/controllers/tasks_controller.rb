class TasksController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_task, only: [:show]
    before_action :set_board, only: [:new, :show, :create]
    def show
        @comments = @task.comments
    end

    def new
        @task = @board.tasks.build
        @task.user_id = current_user.id
    end

    def create
        @task = @board.tasks.build(task_params)
        @task.user_id = current_user.id

        if @task.save
            redirect_to board_path(@board), notice: 'タスクを追加'
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
          redirect_to board_task_path, notice: '更新できました'
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

    def set_task
        @task = Task.find(params[:id])
    end

    def set_board
        @board = Board.find(params[:board_id])
    end

end
