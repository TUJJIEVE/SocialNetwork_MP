class UserInterst < ApplicationRecord
    belongs_to :tag
    belongs_to :user
    
    validates_presence_of :tag_id, :user_id
    
    def UserInterst::Create(user_id,tag_id)
        user_interst = UserInterst.new
        user_interst.user_id = user_id
        user_interst.tag_id = tag_id
        if user_interst.save 
            puts "created user intrest"
        else
            puts "error creating user intrest"
            puts user_interst.errors.full_messages
            return nil
        end
        return user_interst 
    end

    def UserInterst::Find_by_User(id)
        user_intersts = UserInterst.where({"user_id" => id})        
        if user_intersts.length > 0 
            return user_intersts
        end       
        return nil
    end 

    def UserInterst::Delete_by_User(id)
        UserInterst.where({"user_id" => id}).delete_all
    end 

    def UserInterst::Find_by_Tag(id)
        user_intersts = UserInterst.where({"tag_id" => id})        
        if user_intersts.length > 0 
            return user_intersts
        end       
        return nil
    end 
    
    def UserInterst::Exist(user_id,tag_id)
        user_intersts = UserInterst.where({"user_id" => user_id,"tag_id" => tag_id})        
        if user_intersts.length > 0 
            return user_intersts[0]
        end       
        return nil
    end     
end
