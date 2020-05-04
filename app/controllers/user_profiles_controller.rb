class UserProfilesController < ApplicationController

    def show                
        id = 0
        if user_signed_in?
            id = current_user.id
        end
        if params["id"] != nil 
            id = params["id"].to_i
        end                
        @user_profile = UserProfile.where({:user_id => id}).last
        @intersts = UserInterst.Find_by_User(current_user.id)
    end       

    def edit
        if user_signed_in? 
            @user_profile = UserProfile.where({:user_id => current_user.id}).last        
        else
            redirect_to dont_do_mischievous_path
        end
    end

    def edit_intersts
        if user_signed_in?
            @intersts = UserInterst.Find_by_User(current_user.id)            
        else
            redirect_to dont_do_mischievous_path        
        end
    end

    def update_intrests
        if user_signed_in?
            tagIds = []
            puts "==============================="
            tag_names = params["tags"].split(",")
            puts "tags :: " 
            tag_names.each do |tag_name|
                if tag_name.length > 0 
                    puts tag_name
                    id = Tag.GetId(tag_name.squish) #squish will remove trailing spaces
                    if id != nil 
                        tagIds << id
                    else 
                        puts "error :: unknown tag entered"
                    end
                end
            end
            puts "==================================="
            puts tagIds

            UserInterst::Delete_by_User(current_user.id)

            tagIds.each do |tag_id|
                UserInterst.Create(current_user.id,tag_id)
            end
            redirect_to current_user_profile_path
        else
            redirect_to dont_do_mischievous_path        
        end
    end

    def update
        if user_signed_in? 
            @user_profile = UserProfile.where({:user_id => current_user.id}).last        
            puts params[:new_params]
            @user_profile.full_name = params[:new_params]["full_name"]
            @user_profile.dob = params[:new_params][:dob]
            @user_profile.college_id = params[:new_params][:college_id]
            @user_profile.country = params[:new_params][:country]
            if params[:new_params][:profile_picture] != nil 
                @user_profile.profile_picture.attach(params[:new_params][:profile_picture])        
            end

            if @user_profile.save 
                puts 'saved successfully.............'
            else
                puts 'failed miserablly............'
            end
            redirect_to '/user_profiles/'
        else
            flash[:error] = "what is this...." 
        end
    end

    def new 
        @new_user_profile = UserProfile.build_user_profile
        puts "saved hurrey....\n\nreached some where\n\n....."
    end
    
    # def create
    #     @current_user_profile = UserProfile.new(profile_params)
    #     @current_user_profile.id = current_user.id    
    #     @current_user_profile.user_id = current_user.id    
    #     if @current_user_profile.save
    #         flash[:success] = "Profile saved"
    #         puts "saved hurrey....\n\nadfasdfadsf\n\n....."
    #     else 
    #         flash[:error] = "Profile not saved"
    #         puts "craped up......\n\nadfasdfadsf\n\n......."
    #     end        
    #     respond_with(@current_user_profile)
    # end
end
