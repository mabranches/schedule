class SchedulingsController < ApplicationController
  before_action :set_scheduling, only: [:show, :edit, :update, :destroy]

  # GET /schedulings
  def index
    monday = DateUtils.this_monday
    friday = DateUtils.this_friday
    @schedulings = Scheduling.where(day:monday..friday)
    @user = current_user
  end

  # GET /schedulings/1
  def show
  end

  # GET /schedulings/new
  def new
    @scheduling = Scheduling.new
  end

  # GET /schedulings/1/edit
  def edit
  end

  # POST /schedulings
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

  # PATCH/PUT /schedulings/1
  def update
    if @scheduling.update(scheduling_params)
      redirect_to @scheduling, notice: 'Scheduling was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /schedulings/1
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
    # Use callbacks to share common setup or constraints between actions.
    def set_scheduling
      @scheduling = Scheduling.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def scheduling_params
      params.require(:scheduling).permit(:day, :hour, :lock_version, :user_id)
    end
end
