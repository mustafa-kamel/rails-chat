class MessagesController < ApplicationController
  before_action :set_message, only: [:show]

  # GET applications/:application_id/chats/:chat_id/messages
  def index
    @messages = Message.get_all(params[:application_id], params[:chat_id])

    render json: @messages
  end

  # GET applications/:application_id/chats/:chat_id/messages/1
  def show
    render json: @message
  end

  # POST applications/:application_id/chats/:chat_id/messages
  def create
    @message = Message.create_message(message_params[:application_id], message_params[:chat_id], message_params[:content])

    if @message.save
      render json: @message, status: :created, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.get_by_number(params[:application_id], params[:chat_id], params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:chat, :number, :body)
    end
end
