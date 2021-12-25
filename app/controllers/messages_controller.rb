class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update]

  # GET applications/:application_token/chats/:chat_number/messages
  def index
    @messages = Message.get_all(params[:application_id], params[:chat_id])

    render json: @messages
  end

  # GET applications/:application_token/chats/:chat_number/messages/1
  def show
    render json: @message
  end

  # POST applications/:application_token/chats/:chat_number/messages
  def create
    @message = Message.create_message(params[:application_id], params[:chat_id], params[:body])
    if @message
      render json: @message, status: :created, location: @message
    else
      render json: {"error": "Invalid input."}, status: :unprocessable_entity
    end
  end

  # PATCH applications/:application_token/chats/:chat_number/messages/:message_number
  def update
    @message = Application.find_by(token: params[:application_id])&.chats&.find_by(number: params[:chat_id])&.messages&.where(number: params[:id]).update(message_params)
    if @message
      render json: @message.as_json(:except => [:id, :chat_id, :lock_version]), status: :ok
    else
      render json: {"error": "Invalid input."}, status: :unprocessable_entity
    end
  end

  # GET applications/:application_token/chats/:chat_number/search/:query
  def search
    query = MessageIndex.search(params[:query].to_s)
    @results = query.records
    @total_results = query.total_entries
    render json: @results.as_json(:except => [:id, :chat_id, :lock_version])
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
