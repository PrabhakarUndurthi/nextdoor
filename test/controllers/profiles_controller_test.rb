require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "should get the profile page" do
    get :show, id: users(:tom).user_name
    assert_response :success
    assert_template 'profiles/show'
  end

  test "should  render 404  on profile name  not found" do
  	get :show, id: "no user"
  	assert_response :not_found	
  end

  test "that all the variables are assigned correctly on profile viewing" do
  	get :show, id: users(:tom).user_name
  	assert assigns(:user)
  	assert_not_empty assigns(:statuses)
  end

  test "that profile displays only the user statuses" do
  	get :show, id: users(:tom).user_name
  	assigns(:statuses).each do |status|
  		assert_equal users(:tom), status.user
  	end
  end
end
