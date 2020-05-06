class MessagesController < ApplicationController    
    before_action :findConversation  
    
    def index
        puts "=========================================="
        if user_signed_in?
            puts @conversation.sender_id
            @messages = @conversation.messages
        else
            redirect_to dont_do_mischievous_path
        end                
    end

    def new
        @message = @conversation.messages.new
    end

    def create
        if user_signed_in?
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
        else
            redirect_to dont_do_mischievous_path
        end        
    end

    def fetchNewMessages
        if user_signed_in?
            puts params
            lastmsgid = params["lastmsgid"]
            msgs = @conversation.messages.where("id > ?", lastmsgid)        
            results = {}
            if msgs.length > 0 
                results["messages"] = msgs
            end
            render json: results
        else
            render json: {}
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
