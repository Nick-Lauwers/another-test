# complete

class ConversationsController < ApplicationController

  def index
    @users = User.all
    @conversations = Conversation.involving(current_user)
  end
  
  def create
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end
  
  def destroy
    @conversation.destroy
    flash[:success] = "Conversation deleted"
    redirect_to conversations_path
  end
  
  private
  
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end
end

# ensure that user is logged in