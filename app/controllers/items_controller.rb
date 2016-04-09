class ItemsController < ApplicationController

  include BbInventoryHelpers::Cart

  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    # create cart
    create_cart
    # age list with only keys
    al = Item::AGE_LIST.to_h
    gl = Item::GENDER_LIST.to_h
    @gender_list = Item::GENDER_LIST.to_h
    @age_list = Item::AGE_LIST.to_h 
    # Filter record OR Return all items
    @filterrific = initialize_filterrific( Item, params[:filterrific], 
      select_options: { 
        by_category: Category.alphabetical.all.to_a.map(&:name),
        by_age_category: @age_list,
        by_gender: @gender_list },
        persistence_id: false) or return 
    @items = @filterrific.find.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @gender_list = Item::GENDER_LIST.to_h
    @age_list = Item::AGE_LIST.to_h 
    @total_quantity = @item.total_quantity
  end

  # GET /items/new
  def new
    # @item = Item.new
    # @bcode = params[:barcode]
    # i = Item.where("barcode = ?", @bcode)
    # if (i!=nil):
    redirect_to get_new_barcode_path
  end

  # NEW ITEM -> BARCODE -> FORM -> SAVE ITEM

  def get_new_barcode
    # @item = Item.new
    # redirect_to get_new_item_info_path(@item)
  end

  def get_new_item_info
    @categories = Category.alphabetical
    barcode = params[:barcode]
    name = params[:name]
    print 'Name: ', name
    # if item doesn't have barcode, don't autopopulate form
    # Barcode takes precedence over name
    if barcode != ''
      @item = Item.find_by barcode: barcode 
    elsif name !=''
      print 'Reached'
      @item = Item.search_by_name(name).first
      print 'Item: ', @item
    else
      @item=nil
    end

    if @item.nil?
      @item = Item.new
      @item.barcode = barcode
      @total_quantity = 0
      render 'new'
    else
      redirect_to edit_item_path(@item.id)
    end

    # barcode = params[:barcode]
    # @item = Item.where("barcode=?", @bcode)
    # redirect_to action: "new", barcode: @bcode
    # render 'new'
  end

  # GET /items/1/edit
  def edit
    print 'Item: ', @item
    @total_quantity = @item.total_quantity
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    if @item.donated=='1'
      @item.donated_quantity = item_params['check_in_quantity']
      @item.bought_quantity = 0
    else
      @item.bought_quantity = item_params['check_in_quantity']
      @item.bought_quantity = 0
    end

    respond_to do |format|
      if @item.save

        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update

    quantity_increase = item_params[:check_in_quantity].to_i
    previous_donated_quantity = @item.donated_quantity
    previous_bought_quantity = @item.bought_quantity

    # save previous price. Update only if new price is not blank.
    price = @item.unit_price

    respond_to do |format|
      if @item.update(item_params)

        if @item.donated=='1'
          @item.donated_quantity = previous_donated_quantity + quantity_increase
        else
          @item.bought_quantity = previous_bought_quantity + quantity_increase
        end

        if item_params[:unit_price]==''
          @item.unit_price = price
        end

        @item.save!

        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:barcode, :unit_price, :check_in_quantity, :name, :gender, :donated, :notes, :category_id, :age=>[])
    end
end
