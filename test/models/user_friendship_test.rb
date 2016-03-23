require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

  test "creating friendships should work without raising an exception"do
   assert_nothing_raised do
   	UserFriendship.create user: users(:tom), friend: users(:mike)
   end  	
  end

  test "creating user friendships with user_id and friend_id" do
  	UserFriendship.create user_id: users(:tom).id, friend_id: users(:ram).id
  	assert users(:tom).friends.include?(users(:ram))
  end
end
