require 'test_helper'

class ItemCheckinsControllerTest < ActionController::TestCase
  setup do
    @item_checkin = item_checkins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_checkins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_checkin" do
    assert_difference('ItemCheckin.count') do
      post :create, item_checkin: { checkin_date: @item_checkin.checkin_date, donated: @item_checkin.donated, item_id: @item_checkin.item_id, quantity_checkedin: @item_checkin.quantity_checkedin, quantity_remaining: @item_checkin.quantity_remaining, unit_price: @item_checkin.unit_price }
    end

    assert_redirected_to item_checkin_path(assigns(:item_checkin))
  end

  test "should show item_checkin" do
    get :show, id: @item_checkin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item_checkin
    assert_response :success
  end

  test "should update item_checkin" do
    patch :update, id: @item_checkin, item_checkin: { checkin_date: @item_checkin.checkin_date, donated: @item_checkin.donated, item_id: @item_checkin.item_id, quantity_checkedin: @item_checkin.quantity_checkedin, quantity_remaining: @item_checkin.quantity_remaining, unit_price: @item_checkin.unit_price }
    assert_redirected_to item_checkin_path(assigns(:item_checkin))
  end

  test "should destroy item_checkin" do
    assert_difference('ItemCheckin.count', -1) do
      delete :destroy, id: @item_checkin
    end

    assert_redirected_to item_checkins_path
  end
end
