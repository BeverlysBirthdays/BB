require 'test_helper'

class BinsControllerTest < ActionController::TestCase
  setup do
    @bin = bins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bin" do
    assert_difference('Basket.count') do
      post :create, bin: { checkout_date: @bin.checkout_date }
    end

    assert_redirected_to bin_path(assigns(:bin))
  end

  test "should show bin" do
    get :show, id: @bin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bin
    assert_response :success
  end

  test "should update bin" do
    patch :update, id: @bin, bin: { checkout_date: @bin.checkout_date }
    assert_redirected_to bin_path(assigns(:bin))
  end

  test "should destroy bin" do
    assert_difference('Basket.count', -1) do
      delete :destroy, id: @bin
    end

    assert_redirected_to bins_path
  end
end
