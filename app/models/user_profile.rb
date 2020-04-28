class UserProfile < ApplicationRecord
    belongs_to :user 
    after_initialize :init

    has_one_attached :profile_picture    

    def init
        self.uname ||= "def_uname" if self.has_attribute? :uname
        self.full_name ||= "def_fullname" if self.has_attribute? :full_name
        self.college_id ||= "def_collegeId" if self.has_attribute? :college_id
        self.country ||= "india" if self.has_attribute? :country
        self.points ||= 0 if self.has_attribute? :points                        
    end
    
    def UserProfile::Create(id)
        v = UserProfile.where({"user_id" => id})        
        if v.length > 0 
            return v[0]
        end       
        #creating new UserProfile when user is not there
        v = UserProfile.new
        v.user_id = id
        if v.save 
            puts "creating user profile"
        else
            puts "error creating user profile"
            puts v.errors.full_messages
        end
        return v
    end
end
