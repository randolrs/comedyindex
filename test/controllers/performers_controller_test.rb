require 'test_helper'

class PerformersControllerTest < ActionController::TestCase
  setup do
    @performer = performers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:performers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create performer" do
    assert_difference('Performer.count') do
      post :create, performer: { bio: @performer.bio, city: @performer.city, country: @performer.country, facebook_url: @performer.facebook_url, instagram_url: @performer.instagram_url, name: @performer.name, twitter_url: @performer.twitter_url, video_url: @performer.video_url, youtube_url: @performer.youtube_url }
    end

    assert_redirected_to performer_path(assigns(:performer))
  end

  test "should show performer" do
    get :show, id: @performer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @performer
    assert_response :success
  end

  test "should update performer" do
    patch :update, id: @performer, performer: { bio: @performer.bio, city: @performer.city, country: @performer.country, facebook_url: @performer.facebook_url, instagram_url: @performer.instagram_url, name: @performer.name, twitter_url: @performer.twitter_url, video_url: @performer.video_url, youtube_url: @performer.youtube_url }
    assert_redirected_to performer_path(assigns(:performer))
  end

  test "should destroy performer" do
    assert_difference('Performer.count', -1) do
      delete :destroy, id: @performer
    end

    assert_redirected_to performers_path
  end
end
