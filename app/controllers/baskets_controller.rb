class BasketsController < ApplicationController

  include BbInventoryHelpers::Cart

  before_action :set_basket, only: [:show, :edit, :update, :destroy]

  # GET /baskets
  # GET /baskets.json
  def index
    @baskets = Basket.all.paginate(:page => params[:page]).per_page(10)
  end

  # GET /baskets/1
  # GET /baskets/1.json
  def show
    @basket_items = @basket.basket_items
  end

  # GET /baskets/new
  def new
    @basket = Basket.new
    @basket_items_in_cart = get_list_of_items_in_cart
    if @basket_items_in_cart.empty?
        redirect_to items_path, notice: "No items in cart to checkout"
    end
  end

  # GET /baskets/1/edit
  def edit
  end

  # POST /baskets
  # POST /baskets.json
  def create
    @basket = Basket.new(basket_params)
    @basket.checkout_date = Date.today

    respond_to do |format|
      if @basket.save
        # update basket_items from cart
        save_each_item_in_cart(@basket)

        # decrease item quantity in inventory
        for bi in @basket.basket_items
          bi.item.quantity -= bi.quantity
          bi.item.save!
        end

        # clear cart
        clear_cart
        
        format.html { redirect_to @basket, notice: 'Basket was successfully created.' }
        format.json { render :show, status: :created, location: @basket }
      else
        @basket_items_in_cart = get_list_of_items_in_cart

        format.html { render :new }
        format.json { render json: @basket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /baskets/1
  # PATCH/PUT /baskets/1.json
  def update
    respond_to do |format|
      if @basket.update(basket_params)
        format.html { redirect_to @basket, notice: 'Basket was successfully updated.' }
        format.json { render :show, status: :ok, location: @basket }
      else
        format.html { render :edit }
        format.json { render json: @basket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /baskets/1
  # DELETE /baskets/1.json
  def destroy
    @basket.destroy
    respond_to do |format|
      format.html { redirect_to baskets_url, notice: 'Basket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_basket
      @basket = Basket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def basket_params
      # params.require(:basket).permit(:checkout_date)
    end
end
