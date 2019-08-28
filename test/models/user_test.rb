require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user = User.new(name: "Example User", email: "user@example.com", password: "password", password_confirmation: "password")
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "name should be present" do
  	@user.name = ""
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = ""
  	assert @user.invalid?
  end

  test "name should not be too long" do
  	@user.name = "a" * 51
  	assert @user.invalid?
  end

  test "email should not be too long" do
  	@user.email = "a" * 256 + "@email.com"
  	assert @user.invalid?
  end

  test "email validation should accept valid addresses" do
  	valid_emails = %w[user@email.com USER@foo.com]
  	valid_emails.each do |valid_email|
  		@user.email = valid_email
  		assert @user.valid?, "#{valid_email.inspect} should be valid"
  	end
  end

  test "email validation should reject invalid addresses" do
  	invalid_emails = %w[user@email,com user_at.org]
  	invalid_emails.each do |invalid_email|
  		@user.email = invalid_email
  		assert @user.invalid?, "#{invalid_email.inspect} should be invalid"
  	end
  end

  test "email address should be unique" do
  	duplicate_user = @user.dup
  	duplicate_user.email = @user.email.upcase
  	@user.save
  	assert duplicate_user.invalid?
  end

  test "password should be present (nonblank)" do
  	@user.password = @user.password_confirmation = " " * 6
  	assert @user.invalid?
  end

  test "password should have minimum length" do
  	@user.password = @user.password_confirmation = "a" * 6
  	assert @user.invalid?
  end
end
