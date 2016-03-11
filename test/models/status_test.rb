require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  test "that status has content" do
  	status = Status.new
  	assert !status.save
  	assert !status.errors[:content].empty?
  end

  test "that status has at least two characters in it" do
	  status = Status.new
	  status.content = "H"
	  assert !status.save
	  assert !status.errors[:content].empty?
  end

  test "that status has a user_id associate with it" do
  	status = Status.new
  	status.user_id = users(:tom)
  	assert !status.save
  	assert !status.errors[:user_id].empty?
  end
end
