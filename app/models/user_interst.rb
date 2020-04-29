class UserInterst < ApplicationRecord
    belongs_to :tag
    belongs_to :user
    
    validates_presence_of :tag_id, :user_id

    def UserInterst::Create(user_id,tag_id)
        user_intrest = UserInterst.new
        user_intrest.user_id = user_id
        user_intrest.tag_id = tag_id
        if user_intrest.save 
            puts "created user intrest"
        else
            puts "error creating user intrest"
            puts user_intrest.errors.full_messages
            return nil
        end
        return user_intrest 
    end
    def UserProfile::Find_by_User(id)
        user_intrests = UserInterst.where({"user_id" => id})        
        if user_intrests.length > 0 
            return user_intrests
        end       
        return nil
    end 
    def UserProfile::Find_by_Tag(id)
        user_intrests = UserInterst.where({"tag_id" => id})        
        if user_intrests.length > 0 
            return user_intrests
        end       
        return nil
    end 
    def UserProfile::Exist(user_id,tag_id)
        user_intrests = UserInterst.where({"user_id" => user_id,"tag_id" => tag_id})        
        if user_intrests.length > 0 
            return user_intrests
        end       
        return nil
    end     
end
