class BinsController < ApplicationController

  include BbInventoryHelpers::Cart

  before_action :set_bin, only: [:show, :edit, :update, :destroy]

  # GET /bins
  # GET /bins.json
  def index
    @bins = Bin.all.paginate(:page => params[:page]).per_page(10)
  end

  # GET /bins/1
  # GET /bins/1.json
  def show
    @bin_items = @bin.bin_items
  end

  # GET /bins/new
  def new
    @bin = Bin.new
    @bin_items_in_cart = get_list_of_items_in_cart
    if @bin_items_in_cart.empty?
        redirect_to items_path, notice: "No items in basket to checkout"
    end
  end

  # GET /bins/1/edit
  def edit
  end

  # POST /bins
  # POST /bins.json
  def create
    @bin = Bin.new(bin_params)
    @bin.checkout_date = Date.today

    respond_to do |format|
      if @bin.save
        # update bin_items from cart
        save_each_item_in_cart(@bin)

        # decrease item quantity in inventory
        for bi in @bin.bin_items
          bi.item.quantity -= bi.quantity
          bi.item.save!
        end

        # clear cart
        clear_cart
        
        format.html { redirect_to @bin, notice: 'bin was successfully created.' }
        format.json { render :show, status: :created, location: @bin }
      else
        @bin_items_in_cart = get_list_of_items_in_cart

        format.html { render :new }
        format.json { render json: @bin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bins/1
  # PATCH/PUT /bins/1.json
  def update
    respond_to do |format|
      if @bin.update(bin_params)
        format.html { redirect_to @bin, notice: 'bin was successfully updated.' }
        format.json { render :show, status: :ok, location: @bin }
      else
        format.html { render :edit }
        format.json { render json: @bin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bins/1
  # DELETE /bins/1.json
  def destroy
    @bin.destroy
    respond_to do |format|
      format.html { redirect_to bins_url, notice: 'bin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bin
      @bin = Bin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bin_params
      # params.require(:bin).permit(:checkout_date)
    end
end
