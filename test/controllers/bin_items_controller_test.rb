require 'test_helper'

class BinItemsControllerTest < ActionController::TestCase
  setup do
    @bin_item = bin_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bin_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bin_item" do
    assert_difference('binItem.count') do
      post :create, bin_item: { bin_id: @bin_item.bin_id, item_id: @bin_item.item_id, quantity: @bin_item.quantity }
    end

    assert_redirected_to bin_item_path(assigns(:bin_item))
  end

  test "should show bin_item" do
    get :show, id: @bin_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bin_item
    assert_response :success
  end

  test "should update bin_item" do
    patch :update, id: @bin_item, bin_item: { bin_id: @bin_item.bin_id, item_id: @bin_item.item_id, quantity: @bin_item.quantity }
    assert_redirected_to bin_item_path(assigns(:bin_item))
  end

  test "should destroy bin_item" do
    assert_difference('binItem.count', -1) do
      delete :destroy, id: @bin_item
    end

    assert_redirected_to bin_items_path
  end
end
