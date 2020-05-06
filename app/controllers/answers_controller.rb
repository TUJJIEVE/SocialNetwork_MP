class AnswersController < ApplicationController
    require 'date'
    def create
        @question = Question.find(params[:question_id])
        @answer = @question.answers.build(answer_params)
        @answer.posted_by = current_user.id
        @answer.save 
        redirect_to question_path(@question)
            
    end

    def edit
        @question = Question.find(params[:question_id])
        @answer = @question.answers.find(params[:id])        
    end
    def upvote
        @question = Question.find(params[:question_id])
        @answer = @question.answers.find(params[:id])  
        @is_ok = AVote.check_if_present(current_user.uname,params[:id])
        
        if @is_ok != nil && @is_ok[0].vote_type !=1
            puts "Already voted this answer"
        else
            if ((@is_ok != nil) && (@is_ok[0].vote_type == 1))
                puts "Already downvoted this answer destroying"
                @is_ok[0].destroy
            end 
            puts "Upvoting this answer"
            @upvote = @answer.a_votes.build()
            @upvote.vote_type = 0
            @upvote.voted_by = current_user.uname
            puts @upvote.vote_id
            if @upvote.save
                redirect_to question_path(@question)
            else
                puts "ERRROR :cannot vote"
            end
        end
    end
    def downvote
        @question = Question.find(params[:id])
        @answer = @question.answers.find(params[:id])


        @is_ok = AVote.check_if_present(current_user.uname,params[:id])
        if @is_ok != nil && @is_ok[0].vote_type !=0

            puts "ALready Voted this answer"
        
        else
            if ( (@is_ok != nil) && (@is_ok[0].vote_type == 0))
                puts @is_ok[0].id
                @is_ok[0].destroy
                puts "Already upvoted this answer now destroying"
            end            
            puts "Downvoting this answer"
            @downvote = @answer.a_votes.build()

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
        @question = Question.find(params[:question_id])
        @answer = @question.answers.find(params[:id])
        if @answer.update(answer_params)
            redirect_to @question
        else
            render 'edit'
        end
    end

    def destroy
        @question = Question.find(params[:question_id])
        @answer = @question.answers.find(params[:id])
        @answer.destroy
        redirect_to question_path(@question)
    end

    private
        def answer_params
            params.require(:answer).permit(:body)
        end 
end
