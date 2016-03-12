require 'test_helper'

class CustomRoutesTest < ActionDispatch::IntegrationTest
  test "that /login path opens the login url" do
  	get '/login'
  	assert_response :success
  end

  test "that /register path opens the register url" do
  	get '/register'
  	assert_response :success
  end

  test "that /logout path logout the session" do
  	get '/logout'
  	assert_response :redirect
  	assert_redirected_to '/'
  end

  test "that /ram path goes to the correct profile page" do
  	get '/ram'
  	assert_response :success
  end
end
