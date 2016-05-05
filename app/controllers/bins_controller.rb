class BinsController < ApplicationController

  # ensure user logged in
  authorize_resource
  
  include BbInventoryHelpers::Cart

  before_action :set_bin, only: [:show, :edit, :update, :destroy]
  # before_action :check_login
  
  # GET /bins
  # GET /bins.json
  def index
    # Filter record OR Return all items
    @filterrific = initialize_filterrific(Bin, params[:filterrific], 
      select_options: { 
        search_by_agency: Agency.alphabetical.all.pluck(:name),
        search_by_program: Program.alphabetical.all.pluck(:name) 
      },
      persistence_id: false ) or return 
    @bins = @filterrific.find.chronological.page(params[:page])
    @total_num_of_bins = @bins.get_total_num_of_bins
  end

  # export bins to csv format
  def export_bins
    @bins = Bin.dump_to_csv
    timestamp = Time.now.to_s
    fname = 'Bins '+ timestamp + '.csv'
    respond_to do |format|
      format.csv { send_data @bins.to_csv, filename: fname}
    end
  end

  # GET /bins/1
  # GET /bins/1.json
  def show
    @bin_items = @bin.bin_items
    @items = @bin.get_unique_items_and_quantity_per_bin
  end

  # GET /bins/new
  def new
    @bin = Bin.new
    @bin_items_in_cart = get_list_of_items_in_cart

    @agencies = Agency.active.alphabetical
    if @bin_items_in_cart.empty?
        redirect_to items_path, notice: "No items in basket to checkout"
    end
  end

  # Edit Method: To get unique item id and qty in bin
  def get_list_of_items_in_bin(bin)

    # dict with item_id and total qty for each item
    item_ids = {}
    for b in bin.bin_items
      # item_checkin
      if !b.item_checkin_id.nil?
        # if in dict
        if item_ids.has_key?(b.item_checkin.item_id)
          item_ids[b.item_checkin.item_id] += b.quantity
        else
          item_ids[b.item_checkin.item_id] = b.quantity
        end
      # item_checkin_archive
      else
        if item_ids.has_key?(b.item_checkin_archive.item_id)
          item_ids[b.item_checkin_archive.item_id] += b.quantity
        else
          item_ids[b.item_checkin_archive.item_id] = b.quantity
        end
      end
    end

    bin_items = Array.new
    # get array from dict
    for k in item_ids.keys()
      info = {item_id: k, quantity: item_ids[k]}
      bin_items << info
    end

    return bin_items 

  end

  # GET /bins/1/edit
  def edit
    @agencies = Agency.active.alphabetical
    @bin_items_in_cart = get_list_of_items_in_bin(@bin)
    print('Bin Items: ', @bin_items_in_cart)
  end

  # POST /bins
  # POST /bins.json
  def create
    @bin = Bin.new(bin_params)
    @bin.checkout_date = Date.today

    respond_to do |format|
      if @bin.save
        # update bin_items from cart
        success = save_each_item_in_cart(@bin)

        if success != false
          # clear cart
          clear_cart

          format.html { redirect_to @bin, notice: 'Bin was successfully created.' }
          format.json { render :show, status: :created, location: @bin }
        else
          # destroy bin since items not in stock
          @bin.destroy

          @bin = Bin.new
          @bin_items_in_cart = get_list_of_items_in_cart
          @agencies = Agency.active.alphabetical
          
          format.html { render :new }
          format.json { render json: @bin.errors, status: :unprocessable_entity }
      
        end 

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
      params.require(:bin).permit(:num_of_bins, :agency_id, :program_id)
    end
end
