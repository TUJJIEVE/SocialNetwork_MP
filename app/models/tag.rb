class Tag < ApplicationRecord    
    validates_presence_of :name
    validates :name, uniqueness: true
    has_many :taggings 
    has_many :questions, through: :taggings
    has_many :ataggings
    has_many :articles, through: :ataggings
    def Tag::GetId(tagname)
        tags = Tag.where({"name" => tagname})        
        if tags.length > 0 
            return tags[0].id
        end       
        return nil
    end        
end
