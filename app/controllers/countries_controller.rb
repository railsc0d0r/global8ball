class CountriesController < ApplicationController
  before_action :set_country, only: [:show]

  # GET /countries
  # GET /countries.json
  def index
    @countries = Country.all

    respond_to do |format|
      format.html { render html: @countries }
      format.json { render json: @countries }
    end
  end

  # GET /countries/1
  # GET /countries/1.json
  def show
    respond_to do |format|
      format.html { render html: @country }
      format.json { render json: @country }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_country
      @country = Country.find_by_id(params[:id])
    end

end
