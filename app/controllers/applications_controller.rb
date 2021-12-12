class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show]

  # GET /applications
  def index
    @applications = Application.select(:token, :name, :chats_count).as_json(:except => :id)

    render json: @applications
  end

  # GET /applications/1
  def show
    render json: @application
  end

  # POST /applications
  def create
    @application = Application.select(:token, :name, :chats_count).new(application_params)

    if @application.save
      render json: @application.as_json(:only => [:token, :name, :chats_count]), status: :created, location: @application
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.select(:token, :name, :chats_count).find_by(token: params[:id]).as_json(:except => :id)
    end

    # Only allow a list of trusted parameters through.
    def application_params
      params.require(:application).permit(:name)
    end
end
