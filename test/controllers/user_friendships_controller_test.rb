require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase
  context "#new" do
  	context "when not logged in " do
  		should "redirect to the login page" do
  			get :new
  			assert_response :redirect
  		end
  	end

  	context "when logged in" do
  		setup do
  			sign_in users(:tom)
  		end

  		should "get a new page and return success" do
  			get :new
  			assert_response :success
  		end

  		should "should  set a flash error if the friend id is missing" do
  			get :new, {}
  			assert_equal "Friend required", flash[:error]
  		end

  		should "display the friends full name " do
  			get :new, friend_id: users(:mike).id
  			assert_match /#{users(:mike).full_name}/, response.body
  		end

  		should "assign a new user friendships" do
  			get :new, friend_id: users(:mike).id
  			assert assigns(:user_friendship)
  		end

  		should "assign a new  user friendship to the correct user" do
  			get :new, friend_id: users(:mike).id
  			assert_equal users(:mike), assigns(:user_friendship).friend
  		end

  		should "assign new user friendship to the currently logged in user" do
  			get :new, friend_id: users(:mike).id
  			assert_equal users(:tom), assigns(:user_friendship).user
  		end

  		should "render a 404 page if the friends is not found" do
  			get :new, friend_id: "Invalid id"
  			assert_response :not_found
  		end
  	end
  end
end
