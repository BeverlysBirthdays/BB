class ItemCheckinsController < ApplicationController
  before_action :set_item_checkin, only: [:show, :edit, :update, :destroy]

  # GET /item_checkins
  # GET /item_checkins.json
  def index
    @item_checkins = ItemCheckin.all
  end

  # GET /item_checkins/1
  # GET /item_checkins/1.json
  def show
  end

  # GET /item_checkins/new
  def new
    @item_checkin = ItemCheckin.new
  end

  # GET /item_checkins/1/edit
  def edit
  end

  # POST /item_checkins
  # POST /item_checkins.json
  def create
    @item_checkin = ItemCheckin.new(item_checkin_params)

    respond_to do |format|
      if @item_checkin.save
        format.html { redirect_to @item_checkin, notice: 'Item checkin was successfully created.' }
        format.json { render :show, status: :created, location: @item_checkin }
      else
        format.html { render :new }
        format.json { render json: @item_checkin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_checkins/1
  # PATCH/PUT /item_checkins/1.json
  def update
    respond_to do |format|
      if @item_checkin.update(item_checkin_params)
        format.html { redirect_to @item_checkin, notice: 'Item checkin was successfully updated.' }
        format.json { render :show, status: :ok, location: @item_checkin }
      else
        format.html { render :edit }
        format.json { render json: @item_checkin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_checkins/1
  # DELETE /item_checkins/1.json
  def destroy
    @item_checkin.destroy
    respond_to do |format|
      format.html { redirect_to item_checkins_url, notice: 'Item checkin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_checkin
      @item_checkin = ItemCheckin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_checkin_params
      params.require(:item_checkin).permit(:quantity_checkedin, :quantity_remaining, :unit_price, :donated, :checkin_date, :item_id)
    end
end
