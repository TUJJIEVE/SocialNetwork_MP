class Tag < ApplicationRecord    
    validates_presence_of :name , :user_id
    validates :name, uniqueness: true

    def Tag::GetId(tagname)
        tags = Tag.where({"name" => tagname})        
        if tags.length > 0 
            return tags[0].id
        end       
        return nil
    end        
end
