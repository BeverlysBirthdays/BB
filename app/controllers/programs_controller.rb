class ProgramsController < ApplicationController
  before_action :set_program, only: [:show, :edit, :update, :destroy]

  def index
    @programs = Programs.alphabetical.all
  end
  
  def show
  end

  def new
  end

  def create
  end

 

  def edit
  end

  

  def update
  end

  def delete
  end
  
  private 
    # Use callbacks to share common setup or constraints between actions.
    def set_program
      @program= Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def program_params
      params.require(:program).permit(:name, :program_id)
    end

end
