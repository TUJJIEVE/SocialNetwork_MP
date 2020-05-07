require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest

  test "should get index without login" do
    get '/'
    assert_response :success
    assert_equal "index", @controller.action_name
  end

  test "should get index with login" do
    get '/users/sign_in'
    log_in users(:user_one)
    assert_response :success
    get '/'
    assert_response :success
    assert_equal "index", @controller.action_name
    log_out users(:user_one)
  end

  test "should get mischievous w/wo login" do   
    #without login
    get dont_do_mischievous_path
    assert_response :success
    assert_equal "mischievous", @controller.action_name 

    #loggin in and checking  
    get '/users/sign_in'  
    log_in users(:user_one)
    post user_session_url
    follow_redirect!
    assert_response :success
    
    
    #with login
    get dont_do_mischievous_path
    assert_response :success
    assert_equal "mischievous", @controller.action_name
    log_out users(:user_one)
  end  

  test "check that user is not Login in" do
    post user_session_url
    assert_response :success
    # when user not signed in redirect dont happen
    # follow_redirect!
    # assert_response :error
  end
end
