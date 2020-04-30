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
end
