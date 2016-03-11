require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "a user should enter first name" do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
  end

  test "a user should enter last_name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:last_name].empty?
  end

  test "a user should enter user_name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:user_name].empty?
  end

  test "a user should enter a unique user_name" do
  	user = User.new
  	user.user_name = users(:tom).user_name
  	assert !user.save
  	assert !user.errors[:user_name].empty?
  end

  test "user must enter a user_name without any spaces" do
  	user = User.new
  	user.user_name = "My username with spaces"
  	assert !user.save
  	assert !user.errors[:user_name].empty?
  	assert user.errors[:user_name].include?("must be formatted correctly.")	
  end

  test "user name must be formatted correctly" do
    user = User.new(first_name: 'tom', last_name: 'jerry', email: 'tom2@example.com')
    user.password = user.password_confirmation = 'password'
    user.user_name = 'tomjerry2'
    assert user.valid?
  end
end
