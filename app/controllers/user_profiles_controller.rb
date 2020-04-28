class UserProfilesController < ApplicationController

    def show
        puts current_user.id
        puts "sadfjasldkfnsladf=======================asfdsadf"
        puts params
        puts "asdfasdfa========================"
        # debug params
        # flash[:success] = "what is this...." + current_user.id
        @user_profile = UserProfile.where({:user_id => current_user.id}).last
    end
    
    def index
        @user_profiles = UserProfile.all
    end    

    def edit
        if user_signed_in? 
            @user_profile = UserProfile.where({:user_id => current_user.id}).last        
        else
            @user_profile = nil
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
            @user_profile.profile_picture.attach(params[:new_params][:profile_picture])            
            puts "=============================== hola ================="

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
