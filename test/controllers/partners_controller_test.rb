require 'test_helper'

class PartnersControllerTest < ActionController::TestCase
  setup do
    @partner = partners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:partners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create partner" do
    assert_difference('Partner.count') do
      post :create, partner: { company: @partner.company, email: @partner.email, name: @partner.name, phone: @partner.phone, text: @partner.text, type: @partner.type, url: @partner.url }
    end

    assert_redirected_to partner_path(assigns(:partner))
  end

  test "should show partner" do
    get :show, id: @partner
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @partner
    assert_response :success
  end

  test "should update partner" do
    patch :update, id: @partner, partner: { company: @partner.company, email: @partner.email, name: @partner.name, phone: @partner.phone, text: @partner.text, type: @partner.type, url: @partner.url }
    assert_redirected_to partner_path(assigns(:partner))
  end

  test "should destroy partner" do
    assert_difference('Partner.count', -1) do
      delete :destroy, id: @partner
    end

    assert_redirected_to partners_path
  end
end
