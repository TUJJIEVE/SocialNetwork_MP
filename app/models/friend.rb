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

    def Friend::Create(id1,id2,status)
        newRequest = Friend.new
        newRequest.sender_id = id1
        newRequest.accepter_id = id2
        newRequest.status = status
        if newRequest.save 
            puts "new request created succesfully.."
            return newRequest        
        else
            puts "error creating new request"
            puts newRequest.errors.full_messages
            return nil
        end
    end

    def statusMsg()
        if self.status == 0 
            return 'pending request'
        elsif self.status == 1 
            return 'accepted request'
        else 
            return 'not expected this'
        end
        return ''
    end
end
