class ArticlesController < ApplicationController

    def index
        @articles = Article.all
    end


    def new
        @article = Article.new
    end
    def edit
        @article = Article.find(params[:id])
    end
    def destroy
        @article = Article.find(params[:id])
        @article.destroy

        redirect_to articles_path
    end

    def clap

        @article = Article.find(params[:id])
        @is_ok = Clap.check_if_present(current_user.id,params[:id])
        
        if @is_ok != nil 
            flash[:success] = "Already Liked this article"
            puts "Already clapped this article"
            redirect_to article_path(@article)
        else
            puts "clapping this article"
            @clap = @article.claps.build()
            puts current_user.uname
            @clap.claps_by = current_user.id
            
            if @clap.save
                flash[:success] = "Liked the article"
                redirect_to article_path(@article)
            else
                puts "ERRROR :cannot clap"
            end
        end
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title,:body))
            redirect_to @article
        else 
            render 'edit'
        end
    end

    def create
        @article = Article.new(article_params)
        @article.posted_by = current_user.id
        
        puts @article.inspect
        if @article.save 
            # flash[:notice] = "New article posted successfully"
            redirect_to @article
        else
            # flash[:error] = "New article not posted try later"
            render 'new'
        end
    end


    def show
        @article = Article.find(params[:id])
        
    end
    private
        def article_params
            params.require(:article).permit(:title,:body,:all_tags)

        end


end
