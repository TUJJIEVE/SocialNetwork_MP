class AnswersController < ApplicationController
    require 'date'
    def create
        @question = Question.find(params[:question_id])
        @answer = @question.answers.create(answer_params)

        redirect_to question_path(@question)
    end

    def edit
        @question = Question.find(params[:question_id])
        @answer = @question.answers.find(params[:id])        
    end

    def update
        @question = Question.find(params[:question_id])
        @answer = @question.answers.find(params[:id])
        if @answer.update(params.require(:answer).permit(:posted_by,:body))
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
            params.require(:answer).permit(:posted_by,:body)
        end 
end
