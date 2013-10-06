require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "has correct attributes" do
    assert_respond_to @user, :username
    assert_respond_to @user, :password
    assert_respond_to @user, :password_confirmation
    assert_respond_to @user, :authenticate
    assert_respond_to @user, :done
  end

  test "username valid" do
    @user.username = ""
    @user.save
    assert !@user.errors['username'].blank?, "username is not valid"
  end

  test "email valid" do
    @user.email = ''
    @user.save
    assert !@user.errors[:email].blank?, "email is not valid"
  end

  test "password valid" do
    @user.password = ""
    @user.save
    assert !@user.errors[:password].blank?, "password is not valid"
  end

  test "password confirmation valid" do
    @user.password_confirmation = ""
    @user.save
    assert !@user.errors[:password_confirmation].blank?, "password confirmation is not valid"
  end

  test "username correct length" do
    @user.username = 'a'*100
    @user.save
    assert @user.errors[:username].any?, "username has the correct length"
  end

  test "password correct length" do
    @user.password = "jedeveloppejedeveloppejedeveloppe"
    @user.save
    assert @user.errors[:password].any?, "password seems to be valid"
  end

  test "password confirmation matches" do
    @user.password = "jerome1"
    @user.password_confirmation = "jerome2"
    @user.save
    assert_not_equal @user.password, @user.password_confirmation, "password and password confirmation does not match"
    assert_no_match @user.password, @user.password_confirmation, "User password and confirmation password match"
    assert_not @user.errors[:password].any?, "The password does contain any error"
    assert @user.errors[:password_confirmation].any?, "password confirmation wrong"
  end
end
