class QCommentsController < ApplicationController

    def create
        @question = Question.find(params[:question_id])
        @q_comment = @question.q_comments.build(comment_params)
        @q_comment.commenter = current_user.id
        if @q_comment.save
            redirect_to question_path(@question)
        else
            puts "lolololol"
            puts @q_comment.errors.full_messages
            redirect_to questions_path
        end

    end

    def edit
        @question = Question.find(params[:question_id])
        @q_comment = @question.q_comments.find(params[:id])
    end

    def update
        @question = Question.find(params[:question_id])
        @q_comment = @question.q_comments.find(params[:id])
        
        if @q_comment.update(comment_params)
            redirect_to @question
        else
            render 'edit'
        end
    end

    def destroy
        @question = Question.find(params[:question_id])
        @q_comment = @question.q_comments.find(params[:id])
        @q_comment.destroy
        redirect_to question_path(@question)
    end
    private
        def comment_params
            params.require(:q_comment).permit(:body)

        end


end
