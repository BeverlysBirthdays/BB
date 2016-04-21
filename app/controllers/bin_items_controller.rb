class BinItemsController < ApplicationController
  before_action :set_bin_item, only: [:show, :edit, :update, :destroy]

  # GET /bin_items
  # GET /bin_items.json
  def index
    @bin_items = BinItem.all.paginate(:page => params[:page])
  end

  # GET /bin_items/1
  # GET /bin_items/1.json
  def show
  end

  # GET /bin_items/new
  def new
    @bin_item = BinItem.new
  end

  # GET /bin_items/1/edit
  def edit
  end

  # POST /bin_items
  # POST /bin_items.json
  def create
    @bin_item = BinItem.new(bin_item_params)

    respond_to do |format|
      if @bin_item.save
        format.html { redirect_to @bin_item, notice: 'bin item was successfully created.' }
        format.json { render :show, status: :created, location: @bin_item }
      else
        format.html { render :new }
        format.json { render json: @bin_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bin_items/1
  # PATCH/PUT /bin_items/1.json
  def update
    respond_to do |format|
      if @bin_item.update(bin_item_params)
        format.html { redirect_to @bin_item, notice: 'bin item was successfully updated.' }
        format.json { render :show, status: :ok, location: @bin_item }
      else
        format.html { render :edit }
        format.json { render json: @bin_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bin_items/1
  # DELETE /bin_items/1.json
  def destroy
    @bin_item.destroy
    respond_to do |format|
      format.html { redirect_to bin_items_url, notice: 'bin item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bin_item
      @bin_item = BinItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bin_item_params
      params.require(:bin_item).permit(:quantity, :item_id, :bin_id)
    end
end
