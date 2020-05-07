require 'test_helper'

class FriendTest < ActiveSupport::TestCase
  
  def setup    
    @users = [users(:user_one) ,users(:user_two) , users(:user_three)] 
    [0,1,2].each{ |i|
      @users[i].save
    }
  end

  test "verifyThatFindStatusReturnsNilWhenFriendRequestRecordIsNotPresent" do 
    friendrequestrecord = Friend.FindStatus(0,2)
    assert (friendrequestrecord == nil)
  end

  test "verifyThatFindStatusReturnsFriendRequestRecordWhenFriendRequestRecordIsPresent" do 
    Friend.Create(@users[0].id,@users[1].id,0)
    friendrequestrecord = Friend.FindStatus(@users[0].id,@users[1].id)
    assert (friendrequestrecord != nil)
    assert (friendrequestrecord.sender_id == @users[0].id)
    assert (friendrequestrecord.accepter_id == @users[1].id)
    assert (friendrequestrecord.status == 0)
  end

  test "verifyThatCreateReturnsNilWhenFriendRequestRecordIsNotAbleToCreate" do 
    friendrequestrecord = Friend.Create(@users[0].id,0,0)
    assert (friendrequestrecord == nil)
  end

  test "verifyThatCreateReturnsFriendRequestRecordWhenFriendRequestRecordIsAbleToCreate" do 
    friendrequestrecord = Friend.Create(@users[0].id,@users[1].id,0)
    assert (friendrequestrecord != nil)
    assert (friendrequestrecord.sender_id == @users[0].id)
    assert (friendrequestrecord.accepter_id == @users[1].id)
    assert (friendrequestrecord.status == 0)
  end

end
