class TasksController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @tasks = current_user.tasks.order(id: :desc).page(params[:page])
  end
  
  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = 'タスクが正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが投稿されませんでした'
      render :new
    end
  end
  
  def new
    @task = current_user.tasks.build
  end
  
  def edit
    @task = Task.find(params[:id])
  end

  def show
    if current_user.tasks.find_by(id: params[:id])
       @task = Task.find(params[:id])
    else 
      redirect_to root_url
    end
  end
  
  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
  end
  
  private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content,:status,:user)
  end
  
end
