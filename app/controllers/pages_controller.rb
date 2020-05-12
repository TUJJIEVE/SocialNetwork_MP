class PagesController < ApplicationController
    def mischievous    
    end

    def index

        @questions = Question.all
        @articles = Article.all

        ## display top votes questions and most clapped articles

        # @articles.each do |article|

        #     @total_claps = article.claps.count  ## contains claps given to this article

        # end
        sortedq = {}
        i = 0
        @questions.each do |question|
            sortedq[i] = QVote.total_up_votes(question.id) ## stores the upvotes to that question
            i+=1
        end
        
        @mostUpVoted = sortedq.sort_by {|k,v| v}.to_h.keys.reverse
        @mostUpVoted = @mostUpVoted[0,10]
        sortedq = {}
        i = 0
        @articles.each do |article|
            sortedq[i] = Clap.total_claps(article.id) ## stores the upvotes to that article
            i+=1
        end
        
        @mostClapped = sortedq.sort_by {|k,v| v}.to_h.keys.reverse
        @mostClapped = @mostClapped[0,10]

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
        @articles = Article.where("title LIKE '%"+query+"%'")
    end
    
    def searchQuestions_tags
        query = " "
        if params["keyword"].length >0
            query = params["keyword"]
        end
        @questions = Question.tagged_with(query)
        @articles = Article.where("title LIKE '%"+query+"%'")

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

    def about
    end

    private 
    def getFriendRequests
        query = {:accepter_id => current_user.id , :status => 0}
        return Friend.where(query).length    
    end
end
