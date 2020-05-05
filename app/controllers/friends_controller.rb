class FriendsController < ApplicationController
    def sendRequest
        if user_signed_in?
            id1 = current_user.id
            id2 = params["id"].to_i
            @msg = ""
            if id1 == id2 
                @msg = "You dont need to send Friend request to you"
            else 
                if User.exist(id2) 
                    @alreadyExistingSendByMe = Friend.FindStatus(id1,id2)
                    @alreadyExistingSendByHim = Friend.FindStatus(id2,id1)
                    
                    if @alreadyExistingSendByMe != nil                             
                        if @alreadyExistingSendByMe.status == 2 
                            @msg = "the other person REJECTED your request..plese dont bother him"  
                        elsif @alreadyExistingSendByMe.status == 1
                            @msg = "already accepted your friend request"                      
                        else 
                            @msg = "Please Have Paitence , let the other user accept."
                        end
                    end

                    if @alreadyExistingSendByHim != nil
                        if @alreadyExistingSendByHim.status == 2 
                            @msg = "the other person sent request and you rejected him"
                            @alreadyExistingSendByHim.status = 0
                            if @alreadyExistingSendByHim.save 
                                @msg << "Now we have givin you second change go to acceptrequests page and accept his" 
                            else 
                                @msg << "Sorry , this is unappceptable plese contact DEV"
                            end 
                        else 
                            @msg = "Wow , the other user already sent a request ACCEPT his."
                        end                        
                    end                    
                    if @alreadyExistingSendByHim == nil && @alreadyExistingSendByMe == nil 
                        newRequest = Friend.Create(id1,id2,0)      
                        if newRequest == nil 
                            @msg = "Sorry , new Friend Request cant be created." 
                        else 
                            @msg = "Hurray , new Friend request has been send to user , please wait for his acceptence"
                        end                              
                    end                
                else
                    @msg = "Sorry , this user doesnt exist"
                end            
            end
        else 
            redirect_to dont_do_mischievous_path      
        end
    end
    def acceptRequests
        if user_signed_in?
            query = {:accepter_id => current_user.id , :status => 0}
            @acceptingRequests = Friend.where(query)
        else 
            redirect_to dont_do_mischievous_path      
        end        
    end
    def pendingRequests
        if user_signed_in?
            query = {:sender_id => current_user.id , :status => 0}
            @pendingRequests = Friend.where(query)
        else 
            redirect_to dont_do_mischievous_path      
        end
    end
    def rejectedRequests
        if user_signed_in?
            query = {:sender_id => current_user.id , :status => 2}
            @rejectedRequests = Friend.where(query)
        else 
            redirect_to dont_do_mischievous_path      
        end
    end
    def acceptRequest
        if user_signed_in?
            id1 = current_user.id
            id2 = params["id"].to_i
            @msg = ""
            if id1 == id2 
                @msg = "You dont need to accept Friend request to you"
            else 
                if User.exist(id2)                     
                    @alreadyExistingSendByHim = Friend.FindStatus(id2,id1)
                    
                    if @alreadyExistingSendByHim == nil
                        @msg = "User did not send request"
                    else 
                        @alreadyExistingSendByHim.status = 1
                        if @alreadyExistingSendByHim.save                       
                            @msg = "hurray , request accepted"
                        else 
                            @msg = "Sorry , request cant be accepted"
                        end
                    end                                
                else
                    @msg = "Sorry , this other user doesnt exist"
                end            
            end
        else 
            redirect_to dont_do_mischievous_path      
        end
    end
    def rejectRequest
        if user_signed_in?
            id1 = current_user.id
            id2 = params["id"].to_i
            @msg = ""
            if id1 == id2 
                @msg = "You dont need to reject Friend request by you"
            else 
                if User.exist(id2)                     
                    @alreadyExistingSendByHim = Friend.FindStatus(id2,id1)
                    
                    if @alreadyExistingSendByHim == nil
                        @msg = "User did not send request"
                    else 
                        @alreadyExistingSendByHim.status = 2
                        if @alreadyExistingSendByHim.save                       
                            @msg = "hurray , request rejected"
                        else 
                            @msg = "Sorry , request cant be rejected now , try later"
                        end
                    end                                
                else
                    @msg = "Sorry , this other user doesnt exist"
                end            
            end
        else 
            redirect_to dont_do_mischievous_path      
        end
    end
    def all
        if user_signed_in?
            id1 = current_user.id            
            query1 = {:sender_id => current_user.id , :status => 1}
            query2 = {:accepter_id => current_user.id , :status => 1}
            @friends = Friend.where(query1).or(Friend.where(query2))
        else 
            redirect_to dont_do_mischievous_path      
        end
    end 
end
