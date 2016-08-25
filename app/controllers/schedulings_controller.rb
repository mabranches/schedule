class SchedulingsController < ApplicationController
  before_action :set_scheduling, only: [:show, :edit, :update, :destroy]

  def index
    monday = DateUtils.this_monday
    friday = DateUtils.this_friday
    @schedulings = Scheduling.where(day:monday..friday)
    @user = current_user
  end

  def create
    @scheduling = Scheduling.new(scheduling_params)
    @scheduling.user = current_user
    if @scheduling.save
      render json: {message: 'Scheduling was successfully created.'}
    else
      errors = build_model_errors(@scheduling)
      render_error(errors, :unprocessable_entity)
    end
  end

  def destroy
    if (current_user.id == @scheduling.user_id) && @scheduling.destroy
      render json: {message: 'Scheduling was successfully destroyed.'}
    else
      errors = build_model_errors(@scheduling)
      errprs << {title:'user', message:'current user is not owner.'} if
        current_user.id != scheduling.user_id
      render_error(errors, :unprocessable_entity)
    end
  end

  private
    def set_scheduling
      @scheduling = Scheduling.find(params[:id])
    end

    def scheduling_params
      params.require(:scheduling).permit(:day, :hour)
    end
end
