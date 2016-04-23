class AgenciesController < ApplicationController

  # ensure user logged in
  authorize_resource
  
  before_action :set_agency, only: [:show, :edit, :update, :destroy]
  # before_action :check_login
  
  # GET /agencies
  # GET /agencies.json
  def index
    @agencies = Agency.alphabetical.page(params[:page])
  end

  def export_agencies
    @agencies = Agency.dump_to_csv
    timestamp = Time.now.to_s
    fname = 'Agencies '+ timestamp + '.csv'
    respond_to do |format|
      format.csv { send_data @agencies.to_csv, filename: fname}
    end
  end

  # GET /agencies/1
  # GET /agencies/1.json
  def show
  end

  # GET /agencies/new
  def new
    @agency = Agency.new
  end

  # GET /agencies/1/edit
  def edit
  end

  # POST /agencies
  # POST /agencies.json
  def create
    @agency = Agency.new(agency_params)

    respond_to do |format|
      if @agency.save
        format.html { redirect_to @agency, notice: 'Agency was successfully created.' }
        format.json { render :show, status: :created, location: @agency }
      else
        format.html { render :new }
        format.json { render json: @agency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agencies/1
  # PATCH/PUT /agencies/1.json
  def update
    respond_to do |format|
      if @agency.update(agency_params)
        format.html { redirect_to @agency, notice: 'Agency was successfully updated.' }
        format.json { render :show, status: :ok, location: @agency }
      else
        format.html { render :edit }
        format.json { render json: @agency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agencies/1
  # DELETE /agencies/1.json
  def destroy
    @agency.destroy
    respond_to do |format|
      format.html { redirect_to agencies_url, notice: 'Agency was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_agency
    @agency = Agency.find(params[:id])
    if @agency.active == true
      @agency.active = false
      flash[:notice] = "#{@agency.name} has been deactivated"
    else
      @agency.active = true
      flash[:notice] = "#{@agency.name} has been activated"
    end
    @agency.save!
    redirect_to agencies_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agency
      @agency = Agency.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agency_params
      params.require(:agency).permit(:name, :street, :city, :state, :zip, :phone, :email, :active)
    end
end
