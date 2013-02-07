class PeriodicTasksController < ApplicationController
  unloadable

  before_filter :find_project_by_project_id
  before_filter :find_periodic_task, :except => [:new, :create, :index]
  before_filter :init_periodic_task, :only => [:new, :create, :index]

  helper :projects

  def index
    @periodic_tasks = PeriodicTask.find_all_by_project_id(@project.id)
  end

  def new
  end

  def create
    @periodic_task.attributes = params[:periodic_task]
    if @periodic_task.save
      flash[:notice] = l(:periodic_task_created)
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    @periodic_task.attributes = params[:periodic_task]
    if @periodic_task.save
      flash[:notice] = l(:periodic_task_updated)
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @periodic_task.destroy
    flash[:notice] = l(:periodic_task_deleted)
    redirect_to :action => 'index'
  end

  private

  def find_periodic_task
    @periodic_task = PeriodicTask.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def init_periodic_task
    @periodic_task = PeriodicTask.new(:project => @project, :author_id => User.current.id)
  end
end
