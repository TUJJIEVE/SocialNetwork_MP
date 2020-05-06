require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup    
    @users = [users(:user_one) ,users(:user_two) , users(:user_three)] 
    [0,1,2].each{ |i|
      @users[i].save
    }
    @conversations = [conversations(:one),conversations(:two)]
    [0,1].each{ |i|
      @conversations[i].save
    }
    @messages = [messages(:one),messages(:two),messages(:three),messages(:four)]
    [0,1,2,3].each{ |i|
      @messages[i].save
    }
  end
  
  test "allAreInternal" do 
    assert true
  end
  
end
