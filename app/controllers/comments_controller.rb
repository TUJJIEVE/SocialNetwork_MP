class CommentsController < ApplicationController
    def create
        @question = Question.find(params[:question_id])
        @answer = @question.answers.find(params[:answer_id])
        @comment = @answer.comments.build(comment_params)
        @comment.commenter = current_user.id
        if @comment.save
            redirect_to question_path(@question)
        else
            puts "lolololol"
            puts @comment.errors.full_messages
            redirect_to questions_path
        end

    end

    def edit
        @question = Question.find(params[:question_id])
        @answer = @question.answers.find(params[:answer_id])
        @comment = @answer.comments.find(params[:id])
    end

    def update
        @question = Question.find(params[:question_id])
        @answer = @question.answers.find(params[:answer_id])
        @comment = @answer.comments.find(params[:id])
        
        if @comment.update(comment_params)
            redirect_to @question
        else
            render 'edit'
        end
    end

    def destroy
        @question = Question.find(params[:question_id])
        @answer = @question.answers.find(params[:answer_id])
        @comment = @answer.comments.find(params[:id])
        @comment.destroy
        redirect_to question_path(@question)
    end
    private
        def comment_params
            params.require(:comment).permit(:body)

        end


end
