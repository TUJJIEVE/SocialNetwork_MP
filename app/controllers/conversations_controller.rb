class ConversationsController < ApplicationController
    def index
        @current_user_id = current_user.id
        query = "conversations.sender_id = " + @current_user_id.to_s + " OR conversations.reciver_id = " + @current_user_id.to_s 
        @conversations = Conversation.where(query)
    end
    
    def create 
        sender = current_user.id
        reciver = params["Conversation"]["reciver_id"]
        
        puts "kaka kaki " + current_user.id.to_s
        puts sender
        puts reciver

        if current_user.id != params["Conversation"]["sender_id"].to_i
            redirect_to dont_do_mischievous_path
        else             

            alreadyPresent = Conversation.between(sender,reciver)

            puts alreadyPresent
            puts "================="


            if alreadyPresent.present?
                @conversation = alreadyPresent[0]
            else                
                @conversation = Conversation.new
                @conversation.sender_id = current_user.id
                @conversation.reciver_id = params["Conversation"]["reciver_id"]
                unless @conversation.save 
                    redirect_to dont_do_mischievous_path
                end
            end
            puts @conversation.as_json           
            redirect_to conversation_messages_path(params: @conversation.as_json)                               
        end
    end
end
