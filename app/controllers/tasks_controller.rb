class TasksController < ApplicationController

    def new
        @user = current_user
        board = Board.find(params[:board_id])
        @task = board.tasks.build
    end

    def create
        board = Board.find(params[:board_id])
        @task = board.tasks.build(task_params)
        
        if @task.save
            redirect_to board_path(board), notice: 'タスクを追加'
        else
            flash.now[:error] = 'タスクを追加できませんでした'
            render :new
        end
    end

    private
    def task_params
        params.require(:task).permit(:name, :description, :start_day, :end_day)
    end
end