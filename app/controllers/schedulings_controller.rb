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

    if @scheduling.save
      redirect_to @scheduling, notice: 'Scheduling was successfully created.'
    else
      render :new
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
    @scheduling.destroy
    redirect_to schedulings_url, notice: 'Scheduling was successfully destroyed.'
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