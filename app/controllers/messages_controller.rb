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
    @message = Message.create_message(params[:application_id], params[:chat_id], params[:body])

    if @message
      render json: @message, status: :created, location: @message
    else
      render json: {"error": "Invalid input."}, status: :unprocessable_entity
    end
  end

  def search
    puts params
    query = MessageIndex.search(params[:query].to_s)
    @results = query.records
    @total_results = query.total_entries
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.get_by_number(params[:application_id], params[:chat_id], params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:body)
    end
end
