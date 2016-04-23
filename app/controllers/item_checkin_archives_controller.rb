class ItemCheckinArchivesController < ApplicationController

  # ensure user logged in
  authorize_resource
  
  before_action :set_item_checkin_archive, only: [:show, :edit, :update, :destroy]

  # GET /item_checkin_archives
  # GET /item_checkin_archives.json
  def index
    @item_checkin_archives = ItemCheckinArchive.all.page(params[:page])
  end

  # GET /item_checkin_archives/1
  # GET /item_checkin_archives/1.json
  def show
  end

  # GET /item_checkin_archives/new
  def new
    @item_checkin_archive = ItemCheckinArchive.new
  end

  # GET /item_checkin_archives/1/edit
  def edit
  end

  # POST /item_checkin_archives
  # POST /item_checkin_archives.json
  def create
    @item_checkin_archive = ItemCheckinArchive.new(item_checkin_archive_params)

    respond_to do |format|
      if @item_checkin_archive.save
        format.html { redirect_to @item_checkin_archive, notice: 'Item checkin archive was successfully created.' }
        format.json { render :show, status: :created, location: @item_checkin_archive }
      else
        format.html { render :new }
        format.json { render json: @item_checkin_archive.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_checkin_archives/1
  # PATCH/PUT /item_checkin_archives/1.json
  def update
    respond_to do |format|
      if @item_checkin_archive.update(item_checkin_archive_params)
        format.html { redirect_to @item_checkin_archive, notice: 'Item checkin archive was successfully updated.' }
        format.json { render :show, status: :ok, location: @item_checkin_archive }
      else
        format.html { render :edit }
        format.json { render json: @item_checkin_archive.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_checkin_archives/1
  # DELETE /item_checkin_archives/1.json
  def destroy
    @item_checkin_archive.destroy
    respond_to do |format|
      format.html { redirect_to item_checkin_archives_url, notice: 'Item checkin archive was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_checkin_archive
      @item_checkin_archive = ItemCheckinArchive.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_checkin_archive_params
      params.require(:item_checkin_archive).permit(:quantity_checkedin, :unit_price, :donated, :checkin_date, :item_id)
    end
end
