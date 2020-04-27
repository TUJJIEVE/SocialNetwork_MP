class TagsController < ApplicationController
    def create
        @tag = Tag.create
        @tag.name = params["Tag"]["name"]
        @tag.user_id = current_user.id
        if @tag.save 
            flash[:notice] = "new tag saved successfully"
        else
            flash[:error] = "new tag not saved try later"
        end
        redirect_to  all_tags_path
    end
    def index
        @tags = Tag.all                
    end    
    def delete
        #write this function 
    end
end
