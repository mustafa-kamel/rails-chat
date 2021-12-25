class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :update]

  # GET /applications/:application_token/chats
  def index
    @chats = Chat.get_all(params[:application_id])

    render json: @chats
  end

  # GET /applications/:application_token/chats/:chat_number
  def show
    render json: @chat
  end

  # POST /applications/:application_token/chats
  def create
    @chat = Chat.create_chat(params[:application_id])
    if @chat
      render json: @chat, status: :created, location: @chat
    else
      render json: {"error": "Invalid input."}, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.get_by_number(params[:application_id], params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.require(:chat).permit(:application_id)
    end
end
