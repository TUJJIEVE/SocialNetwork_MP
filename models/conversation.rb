class Conversation < ApplicationRecord
    belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
    belongs_to :reciver, :foreign_key => :reciver_id, class_name: 'User'

    has_many :messages , :foreign_key => :conversation_id , class_name: 'Message'
    
    validates_uniqueness_of :sender_id, :scope => :reciver_id 

    scope :between, -> (sender_id,reciver_id) {
        # where(“(conversations.sender_id = :s_id AND conversations.reciver_id = :r_id ) OR (conversations.sender_id = :r_id AND conversations.reciver_id = :s_id )”, s_id: sender_id , r_id: reciver_id)
        query1 = "(conversations.sender_id = " + sender_id.to_s + " AND conversations.reciver_id = " +reciver_id.to_s + ")"  
        query2 = "(conversations.sender_id = " + reciver_id.to_s + " AND conversations.reciver_id = " +sender_id.to_s + ")"  
        query3 = query1 + " OR " + query2
        where(query3)        
    }

end
