require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # called after every single test
  def setup
    @user = users(:user1)
  end

  # called after every single test
  def teardown
    @user = nil
  end

  test "should not create user without github_token, avatar_url, name, provider" do
    user = User.new
    assert !user.save
  end

  test "should create user" do
    user = User.new({provider:'github', uid:'uidunique1', github_token:'tokentest', avatar_url:'avatarurl', name:'webpuzzle'})
    assert user.save
  end

  test "shoud not create user with existing uid" do
    user = User.new({provider:'github', uid:'1234567', github_token:'tokentest2', avatar_url:'avatarurl2', name:'webpuzzle2'})
    assert !user.save
  end

  test "shoud not create user with existing github token" do
      user = User.new({provider:'github', uid:'uidunique2', github_token:'789012', avatar_url:'avatarurl2', name:'webpuzzle2'})
      assert !user.save
  end
end
