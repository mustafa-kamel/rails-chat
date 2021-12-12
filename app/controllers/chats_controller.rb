class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :update, :destroy]

  # GET /applications/:application_id/chats
  def index
    @chats = Chat.get_all(params[:application_id])

    render json: @chats
  end

  # GET /applications/:application_id/chats/1
  def show
    render json: @chat
  end

  # POST /applications/:application_id/chats
  def create
    @chat = Chat.create_chat(params[:application_id])

    if @chat.save
      render json: @chat, status: :created, location: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.get_by_number(params[:application_id], params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.require(:chat).permit(:application, :number)
    end
end
