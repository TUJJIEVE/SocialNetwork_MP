class PagesController < ApplicationController
    def mischievous    
    end

    def index
    end

    def searchUsers
        puts '======================'    
        puts params["keyword"] 
        puts '========================'
        query = " "
        if params["keyword"].length > 0
            query = params["keyword"]
        end
        @users = UserProfile.where("full_name LIKE '%"+query+"%'")
        
        puts @users.length
        
        puts "========================="
    end

    def unacceptedRequests        
        if user_signed_in?
            query = {:accepter_id => current_user.id , :status => 0}
            Friend.where(query).length 
        else 
            redirect_to dont_do_mischievous_path      
        end                    
    end    
end
