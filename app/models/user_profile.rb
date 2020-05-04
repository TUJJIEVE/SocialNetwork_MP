class UserProfile < ApplicationRecord
    belongs_to :user     

    has_one_attached :profile_picture  , :dependent => :purge_later
 
    def UserProfile::Create(uname,user_id)                
        user_profile = UserProfile.new
        user_profile.user_id = user_id
        user_profile.uname = uname
        if user_profile.save 
            puts "creating user profile"
        else
            puts "error creating user profile"
            puts user_profile.errors.full_messages
            return nil
        end
        return user_profile
    end

    def UserProfile::Find(id)
        user_profiles = UserProfile.where({"user_id" => id})        
        if user_profiles.length > 0 
            return user_profiles[0]
        end       
        return nil
    end 
end
