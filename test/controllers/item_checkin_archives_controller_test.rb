require 'test_helper'

class ItemCheckinArchivesControllerTest < ActionController::TestCase
  setup do
    @item_checkin_archive = item_checkin_archives(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_checkin_archives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_checkin_archive" do
    assert_difference('ItemCheckinArchive.count') do
      post :create, item_checkin_archive: { checkin_date: @item_checkin_archive.checkin_date, donated: @item_checkin_archive.donated, item_id: @item_checkin_archive.item_id, quantity_checkedin: @item_checkin_archive.quantity_checkedin, unit_price: @item_checkin_archive.unit_price }
    end

    assert_redirected_to item_checkin_archive_path(assigns(:item_checkin_archive))
  end

  test "should show item_checkin_archive" do
    get :show, id: @item_checkin_archive
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item_checkin_archive
    assert_response :success
  end

  test "should update item_checkin_archive" do
    patch :update, id: @item_checkin_archive, item_checkin_archive: { checkin_date: @item_checkin_archive.checkin_date, donated: @item_checkin_archive.donated, item_id: @item_checkin_archive.item_id, quantity_checkedin: @item_checkin_archive.quantity_checkedin, unit_price: @item_checkin_archive.unit_price }
    assert_redirected_to item_checkin_archive_path(assigns(:item_checkin_archive))
  end

  test "should destroy item_checkin_archive" do
    assert_difference('ItemCheckinArchive.count', -1) do
      delete :destroy, id: @item_checkin_archive
    end

    assert_redirected_to item_checkin_archives_path
  end
end
