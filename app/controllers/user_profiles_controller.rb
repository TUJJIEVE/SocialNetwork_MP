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
            @tags = Tag.all       
        else
            redirect_to dont_do_mischievous_path        
        end
    end

    def update_intrests
        if user_signed_in?
            tagIds = []
            tag_ids = params["tag_ids"]
            
            
            if tag_ids != nil  
                tag_ids.each do |tag_id|
                    if Integer(tag_id, exception: false)
                        tagid = tag_id.to_i 

                        if tagid > 0 
                            puts tagid
                            if Tag.find_by_id(tagid) != nil                    
                                tagIds << tagid
                            else 
                                puts "error :: unknown tagid entered"
                            end
                        end 
                    end
                end
            end

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
            @user_profile.dob = DateTime.parse(params[:new_params][:dob])
            @user_profile.college_id = params[:new_params][:college_id]
            @user_profile.country = params[:new_params][:country]
            if params[:new_params][:profile_picture] != nil 
                @user_profile.profile_picture.attach(params[:new_params][:profile_picture])        
            end

            #intializing points
            if @user_profile.points == nil 
                @user_profile.points = 0       
            end

            #save
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
