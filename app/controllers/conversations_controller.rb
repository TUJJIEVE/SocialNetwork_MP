class ConversationsController < ApplicationController
    def index
        if user_signed_in?
            @current_user_id = current_user.id
            query = "conversations.sender_id = " + @current_user_id.to_s + " OR conversations.reciver_id = " + @current_user_id.to_s 
            @conversations = Conversation.where(query)
        else
            redirect_to dont_do_mischievous_path
        end        
    end
    
    def create 
        if user_signed_in?
            sender = current_user.id
            reciver = 0
            if params["Conversation"].present?
                if params["Conversation"]["reciver_id"].present?
                    if is_number(params["Conversation"]["reciver_id"])
                        reciver = params["Conversation"]["reciver_id"]
                    else
                        flash[:error] = "make sure id is a number"
                    end
                else
                    flash[:error] = "ids not passed to form"
                end
            else
                flash[:error] = "form parameters are incorrect"
            end
            
            if reciver == 0                 
                redirect_to my_conversations_path
            else 
            
                puts "kaka kaki " + current_user.id.to_s
                puts sender
                puts reciver

                if current_user.id != params["Conversation"]["sender_id"].to_i
                    flash[:error] = "you cant create conversation for others"
                    redirect_to dont_do_mischievous_path
                else             

                    alreadyPresent = Conversation.between(sender,reciver)

                    puts alreadyPresent
                    puts "================="

                    @conversation = nil
                    if alreadyPresent.present?
                        @conversation = alreadyPresent[0]
                    else                                    
                        if !User.exist(reciver.to_i) 
                            flash[:error] = "user with id provided dont exist"                            
                        end
                        @conversation = Conversation.new
                        @conversation.sender_id = current_user.id
                        @conversation.reciver_id = params["Conversation"]["reciver_id"]
                        unless @conversation.save 
                            flash[:error] = "you cant start a new conversation ,because " + @conversation.errors.full_messages.to_s
                            @conversation = nil                            
                        end                       
                    end                                              
                    if @conversation != nil 
                        puts @conversation.as_json   
                        redirect_to conversation_messages_path(params: @conversation.as_json)   
                    else
                        redirect_to my_conversations_path 
                    end                            
                end   
            end     
        else
            flash[:error] = "login for starting a conversation"
            redirect_to '/'
        end
    end
end
