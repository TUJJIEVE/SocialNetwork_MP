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
        @users = UserProfile.where("uname LIKE '%"+query+"%'")
        
        puts @users.length
        
        puts "========================="
    end

    def searchQuestions
        query = " "
        if params["keyword"].length >0
            query = params["keyword"]
        end
        @questions = Question.where("title LIKE '%"+query+"%'")
    end
    
    def searchQuestions_tags
        query = " "
        if params["keyword"].length >0
            query = params["keyword"]
        end
        @questions = Question.tagged_with(query)
    end
    def unacceptedRequests        
        if user_signed_in?
            query = {:accepter_id => current_user.id , :status => 0}
            Friend.where(query).length 
        else 
            redirect_to dont_do_mischievous_path      
        end                    
    end    

    def getNotifications        
        results = {}
        results["friendRequests"] = 0
        if user_signed_in?                    
            results["friendRequests"] += getFriendRequests
            puts results            
        end            
        render json: results        
    end

    def notFound
    end

    private 
    def getFriendRequests
        query = {:accepter_id => current_user.id , :status => 0}
        return Friend.where(query).length    
    end
end
