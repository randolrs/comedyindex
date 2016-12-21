require 'test_helper'

class ShowReviewsControllerTest < ActionController::TestCase
  setup do
    @show_review = show_reviews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:show_reviews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create show_review" do
    assert_difference('ShowReview.count') do
      post :create, show_review: { author_id: @show_review.author_id, body: @show_review.body, rating: @show_review.rating, show_id: @show_review.show_id, show_occurence_id: @show_review.show_occurence_id, title: @show_review.title }
    end

    assert_redirected_to show_review_path(assigns(:show_review))
  end

  test "should show show_review" do
    get :show, id: @show_review
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @show_review
    assert_response :success
  end

  test "should update show_review" do
    patch :update, id: @show_review, show_review: { author_id: @show_review.author_id, body: @show_review.body, rating: @show_review.rating, show_id: @show_review.show_id, show_occurence_id: @show_review.show_occurence_id, title: @show_review.title }
    assert_redirected_to show_review_path(assigns(:show_review))
  end

  test "should destroy show_review" do
    assert_difference('ShowReview.count', -1) do
      delete :destroy, id: @show_review
    end

    assert_redirected_to show_reviews_path
  end
end
