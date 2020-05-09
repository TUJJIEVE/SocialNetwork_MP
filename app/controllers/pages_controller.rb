class PagesController < ApplicationController
    def mischievous    
    end

    def index

        @questions_you_intrested_in = nil
        @questions = Question.all
        @articles = Article.all

        if current_user != nil 
            #fills questions you intrested in
            @questions_you_intrested_in = customizedQuestionsForUser()
            if @questions_you_intrested_in != nil 
                sortedq = {}
                i = 0
                puts "=============================="
                puts @questions_you_intrested_in
                puts "================================="
                @questions_you_intrested_in.each do |question|
                    sortedq[i] = QVote.total_up_votes(question.id) ## stores the upvotes to that question
                    i+=1
                end
                @mostUpVotedQuestions_you_intrested_in = sortedq.sort_by {|k,v| v}.to_h.keys.reverse
            end      
        end


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
    
        sortedq = {}
        i = 0
        @articles.each do |article|
            sortedq[i] = Clap.total_claps(article.id) ## stores the upvotes to that article
            i+=1
        end
        
        @mostClapped = sortedq.sort_by {|k,v| v}.to_h.keys.reverse
    

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

    def customizedQuestionsForUser 
        user_intersts = UserInterst.Find_by_User(current_user.id)  
        if user_intersts == nil 
            return nil
        end
        tagIds = []
        
        user_intersts.each { |r|
            tagIds << r.tag_id
        }

        questionIds = Tagging.where({tag_id:tagIds}).pluck(:question_id).uniq
        
        userIntrestedQuestions = Question.find(questionIds)
        #might be used in next update
        # userNotIntrestedQuestions = Question.where.not(id: questionIds)

        return  userIntrestedQuestions
    end
end
