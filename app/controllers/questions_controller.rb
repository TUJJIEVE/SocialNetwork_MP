class QuestionsController < ApplicationController
    require 'date'
    def index
        @questions = Question.all
    end

    def new
        @question = Question.new
    end
    def edit
        @question = Question.find(params[:id])
    end
    def destroy
        @question = Question.find(params[:id])
        @question.destroy

        redirect_to questions_path
    end

    def upvote
        @question = Question.find(params[:id])
        @is_ok = QVote.check_if_present(current_user.uname,params[:id])
        
        if @is_ok != nil && @is_ok[0].vote_type !=1
            puts "Already voted this question"
        else
            if ((@is_ok != nil) && (@is_ok[0].vote_type == 1))
                puts "Already downvoted this question destroying"
                @is_ok[0].destroy
            end 
            puts "Upvoting this question"
            @upvote = @question.q_votes.build()
            @upvote.vote_type = 0
            @upvote.voted_by = current_user.uname
            puts @upvote.vote_id
            if @upvote.save
                redirect_to questions_path(@question)
            else
                puts "ERRROR :cannot vote"
            end
        end
    end
    def downvote
        @question = Question.find(params[:id])



        @is_ok = QVote.check_if_present(current_user.uname,params[:id])
        if @is_ok != nil && @is_ok[0].vote_type !=0

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
                redirect_to question_path(@question)
            else
                puts "Error :cannot vote"
            end
        end
    end
    def update
        @question = Question.find(params[:id])
        # date = params[:date]
        # time = params[:time]
        edited_at = DateTime.now
        @question.updated_at = edited_at
        # puts edited_at  
        if @question.update(params.require(:question).permit(:title,:text))
            redirect_to @question
        else 
            render 'edit'
        end
    end

    def create
        # render plain: params[:question].inspect
        @question = Question.new
        @question.user_id = current_user.id
        @question.question_id = params[:id]
        @question.title = params[:question][:title]
        @question.text = params[:question][:text]
        @question.posted_on = DateTime.now
        @question.created_at = DateTime.now
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
            params.require(:question).permit(:title,:text)

        end

end