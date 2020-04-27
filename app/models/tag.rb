class Tag < ApplicationRecord    
    validates_presence_of :name , :user_id
    validates :name, uniqueness: true
end
