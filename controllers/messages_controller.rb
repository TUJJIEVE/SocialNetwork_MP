class MessagesController < ApplicationController    
    before_action :findConversation  
    
    def index
        puts "=========================================="
        puts @conversation.sender_id
        @messages = @conversation.messages        
    end

    def new
        @message = @conversation.messages.new
    end

    def create
        puts "===============in create messages==========================="        
        puts params
        # @message = @conversation.messages.new(message_params)
        @message = @conversation.messages.new
        @message.user_id = current_user.id
        @message.body = params["Message"]["body"]  
        @message.read = false      
        if @message.save
            redirect_to conversation_messages_path @conversation.as_json        
        end
    end

    private
    def findConversation
        puts "entered in find conversation============================"
        puts params 
        puts "printing params in find conversation"
        conversationId =  params["id"]        
        @conversation = Conversation.find(conversationId)        
    end

    def message_params
       params.require(:Message).permit(:body)
    end
end
