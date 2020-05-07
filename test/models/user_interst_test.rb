require 'test_helper'

class UserInterstTest < ActiveSupport::TestCase
  def setup        
    @tags = [ tags(:one) , tags(:two) ]
    @tags[0].save
    @tags[1].save
    @user = users(:user_one)
    @user.save
    @userprofile = user_profiles(:user_one)    
    @userprofile.save        
  end

  test "verifyThatCreateReturnsNilWhenInvalidIdisGiven" do
    userintrest = UserInterst.Create(1,0)
    assert (userintrest == nil)    
  end

  test "verifyThatCreateReturnsUserInterstObjWhenInvalidIdisGiven" do
    userintrest = UserInterst.Create(@user.id,@tags[0].id)
    assert (userintrest != nil)    
    assert (userintrest.user_id == @user.id)
    assert (userintrest.tag_id == @tags[0].id)
  end

  test "verifyThatExistReturnsNilWhenInvalidIdisGiven" do
    userintrest = UserInterst.Exist(1,0)
    assert (userintrest == nil)    
  end

  test "verifyThatExistReturnsUserInterstObjWhenInvalidIdisGiven" do
    UserInterst.Create(@user.id,@tags[0].id)
    userintrest = UserInterst.Exist(@user.id,@tags[0].id)
    assert (userintrest != nil)    
    assert (userintrest.user_id == @user.id)
    assert (userintrest.tag_id == @tags[0].id)
  end

  
end
