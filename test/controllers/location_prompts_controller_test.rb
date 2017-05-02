require 'test_helper'

class LocationPromptsControllerTest < ActionController::TestCase
  setup do
    @location_prompt = location_prompts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:location_prompts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create location_prompt" do
    assert_difference('LocationPrompt.count') do
      post :create, location_prompt: { address: @location_prompt.address, cta_link: @location_prompt.cta_link, cta_text: @location_prompt.cta_text, latitude: @location_prompt.latitude, longitude: @location_prompt.longitude, message: @location_prompt.message }
    end

    assert_redirected_to location_prompt_path(assigns(:location_prompt))
  end

  test "should show location_prompt" do
    get :show, id: @location_prompt
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @location_prompt
    assert_response :success
  end

  test "should update location_prompt" do
    patch :update, id: @location_prompt, location_prompt: { address: @location_prompt.address, cta_link: @location_prompt.cta_link, cta_text: @location_prompt.cta_text, latitude: @location_prompt.latitude, longitude: @location_prompt.longitude, message: @location_prompt.message }
    assert_redirected_to location_prompt_path(assigns(:location_prompt))
  end

  test "should destroy location_prompt" do
    assert_difference('LocationPrompt.count', -1) do
      delete :destroy, id: @location_prompt
    end

    assert_redirected_to location_prompts_path
  end
end
