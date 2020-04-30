class Friend < ApplicationRecord
    belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
    belongs_to :accepter, :foreign_key => :accepter_id, class_name: 'User'
    
    def Friend::FindStatus(id1,id2)
        # query = "(sender_id = " + id1.to_s + " AND accepter_id = " +id2.to_s + ")"         
        query = {:sender_id => id1 , :accepter_id => id2}
        records = Friend.where(query)
        if records.length > 0 
            return records[0]
        end
        return nil
    end
end
