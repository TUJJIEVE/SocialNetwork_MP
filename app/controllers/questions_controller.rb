class QuestionsController < ApplicationController
    require 'date'
    def index
        @questions = Question.all
    end


    def new
        if user_signed_in?  
            @question = Question.new
        else
            flash[:notice] = "Notice :: please register to ask a question"
            redirect_to root_path
        end
    end
    def edit
        @question = params[:id].present? ? Question.find_by_id(params[:id]) : nil     
        if @question == nil 
            flash[:error] = "question not found"
            redirect_to root_path
        end  
    end
    def destroy
        @question = Question.find(params[:id])
        @question.destroy

        redirect_to questions_path
    end

    def upvote    
        @question = params[:id].present? ? Question.find_by_id(params[:id]) : nil     
        if @question == nil 
            flash[:error] = "question not found"
            redirect_to root_path
        end   
        if user_signed_in?           
            @is_ok = QVote.check_if_present(current_user.uname,params[:id])
            
            if @is_ok != nil && @is_ok[0].vote_type !=1
                flash[:success] = "Already Up-voted this question"
                redirect_to question_path(@question)
                puts "Already voted this question"
            else
                if ((@is_ok != nil) && (@is_ok[0].vote_type == 1))
                    
                    @is_ok[0].destroy
                end 
                puts "Upvoting this question"
                @upvote = @question.q_votes.build()
                @upvote.vote_type = 0
                @upvote.voted_by = current_user.uname
                puts @upvote.vote_id
                if @upvote.save
                    flash[:success] = "Success: Upvote is registered"
                else
                    flash[:error] = "ERRROR : vote is not saved "
                end
                redirect_to question_path(@question)
            end
        else
            flash[:notice] = "please register to vote"
            redirect_to questions_path(@question)
        end
    end
    def downvote
        @question = params[:id].present? ? Question.find_by_id(params[:id]) : nil     
        if @question == nil 
            flash[:error] = "question not found"
            redirect_to root_path
        end   
        if user_signed_in?  
            @is_ok = QVote.check_if_present(current_user.uname,params[:id])
            if @is_ok != nil && @is_ok[0].vote_type !=0
                flash[:success] = "Already Down-voted this question"
                redirect_to question_path(@question)
                puts "ALready Voted this question"
            
            else
                if ( (@is_ok != nil) && (@is_ok[0].vote_type == 0))
                    puts @is_ok[0].id
                    @is_ok[0].destroy
                    puts "Already upvoted this question now destroying"
                end            
                puts "Downvoting this question"
                @downvote = @question.q_votes.build()

                @downvote.vote_type = 1
                @downvote.voted_by = current_user.uname
                puts @downvote.vote_id
                if @downvote.save
                    flash[:success] = "Success: Downvote is registered"
                    redirect_to question_path(@question)
                else
                    puts "Error :cannot vote"
                end
            end
        else
            flash[:notice] = "please register to vote"
            redirect_to questions_path(@question)
        end
    end
    def update        
        @question = params[:id].present? ? Question.find_by_id(params[:id]) : nil     
        if @question == nil 
            flash[:error] = "question not found"
            redirect_to root_path
        end  
        if user_signed_in?  
            # date = params[:date]
            # time = params[:time]
            edited_at = DateTime.now
            @question.updated_at = edited_at
            
                 
            
            # puts edited_at  
            if @question.update(question_params)
                redirect_to @question
            else 
                render 'edit'
            end
        else
            flash[:notice] = "please register to update"
            redirect_to questions_path(@question)
        end
    end

    def create
        # render plain: params[:question].inspect
    
        params["question"]["all_tags"] = params["tag_names"].join(",")
        
        puts question_params
    
        @question = Question.new(question_params)
        @question.user_id = current_user.id
        
        if params["question"]["qimage"] != nil 
            @question.qimage.attach(params["question"]["qimage"])  
        end
        
        puts @question.inspect
        if @question.save 
            # flash[:notice] = "New question posted successfully"
            redirect_to @question
        else
            # flash[:error] = "New question not posted try later"
            render 'new'
        end
    end


    def show
        @question = Question.find(params[:id])
        
    end
    private
        def question_params
            params.require(:question).permit(:title,:text,:all_tags)
        end

end