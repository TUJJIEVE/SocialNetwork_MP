require 'test_helper'

class UserProfileTest < ActiveSupport::TestCase
  
  def setup    
    @def_user = users(:user_one)
    @def_user.save
  end

  test "verifyThatCreateReturnsNilWhenUserIsNotPresent" do 
    userId = 0
    user_profile = UserProfile.Create(userId)    
    assert (user_profile == nil)
  end

  test "verifyThatCreateReturnsUserProfileWhenUserIsPresent" do 
    userId = 1 #id of def_user defined in setup
    user_profile = UserProfile.Create(userId)    
    assert (user_profile != nil)
    assert (user_profile.user_id == userId)
  end

  test "verifyThatFindReturnsNilWhenUserIsNotPresent" do
    userId = 0
    user_profile = UserProfile.Find(userId)    
    assert (user_profile == nil)
  end

  test "verifyThatFindReturnsUserProfileWhenUserIsPresent" do
    userId = 1 #id of def_user defined in setup
    user_profile = UserProfile.Find(userId)    
    assert (user_profile != nil)
  end
end
