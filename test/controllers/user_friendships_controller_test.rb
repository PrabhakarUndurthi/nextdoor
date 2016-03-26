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
  			get :new, friend_id: users(:tom)
  			assert_match /#{users(:tom).full_name}/, response.body
  		end

  		should "assign a new user friendships" do
  			get :new, friend_id: users(:ram)
  			assert assigns(:user_friendship)
  		end

  		should "assign a new  user friendship to the correct user" do
  			get :new, friend_id: users(:tom)
  			assert_equal users(:tom), assigns(:user_friendship).friend
  		end

  		should "assign new user friendship to the currently logged in user" do
  			get :new, friend_id: users(:ram)
  			assert_equal users(:tom), assigns(:user_friendship).user
  		end

  		should "render a 404 page if the friends is not found" do
  			get :new, friend_id: "Invalid id"
  			assert_response :not_found
  		end

      should "ask if you really want to friend with the user" do
        get :new, friend_id: users(:tom)
        assert_match /Do you really want to friend with #{users(:tom).full_name}? /, response.body
      end
  	end
  end

  context "#create" do
    context "when not logged in" do
      should "redirect the user when not loggeed in " do
        get :new
        assert_response :redirect
        assert_redirected_to login_path
      end
    end

    context "when logged in" do
      setup do
        sign_in users(:tom)
      end

      context "with no friend id" do
        setup do
          post :create
        end
        should "set the flash error message" do
          assert !flash[:error].empty?
        end

        should "redirect to the root path" do
          assert_redirected_to root_path
        end
      end

      context "with a valid friend id" do
        setup do
          post :create, user_friendship: {friend_id: users(:ram)}
        end

        should "assign a new friend object" do
          assert assigns(:friend)
          assert_equal users(:ram), assigns(:friend)
        end
        should "assign a new user_friendship" do
          assert assigns(:user_friendship)
          assert_equal users(:tom), assigns(:user_friendship).user
          assert_equal users(:ram), assigns(:user_friendship).friend 
        end
        should "create  a friendship" do
          assert users(:tom).friends.include?(users(:ram))
        end

        should "redirect to the profile page of the new friend" do
          assert_response :redirect
          assert_redirected_to profile_path(users(:ram))
        end

        should "set the flash message" do
          assert flash[:success]
          assert_equal "You are now friends with #{users(:ram).full_name}", flash[:success]
        end
      end
    end
  end
end
