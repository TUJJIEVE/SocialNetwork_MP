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