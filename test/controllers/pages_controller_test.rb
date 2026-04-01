require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(username: "homepage_user", email: "homepage#{SecureRandom.hex(4)}@example.com", password: "password")
  end

  test "should render redesigned homepage for guests" do
    get root_path
    assert_response :success
    assert_match "Editorial reading platform", response.body
  end

  test "should render redesigned homepage for logged in users" do
    sign_in_as(@user, "password")
    get root_path
    assert_response :success
    assert_match "Editorial reading platform", response.body
    assert_match "Start writing", response.body
  end
end
