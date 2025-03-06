require "test_helper"

class SocialLinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @social_link = social_links(:kalogs_c_github)
  end

  test "should get index" do
    get social_links_url, as: :json
    assert_response :success
  end

  test "should create social_link" do
    assert_difference("SocialLink.count") do
      post social_links_url, params: { social_link: { description: @social_link.description, url: @social_link.url, user_id: @social_link.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show social_link" do
    get social_link_url(@social_link), as: :json
    assert_response :success
  end

  test "should update social_link" do
    patch social_link_url(@social_link), params: { social_link: { description: @social_link.description, url: @social_link.url, user_id: @social_link.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy social_link" do
    assert_difference("SocialLink.count", -1) do
      delete social_link_url(@social_link), as: :json
    end

    assert_response :no_content
  end
end
