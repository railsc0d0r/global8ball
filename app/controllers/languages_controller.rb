class LanguagesController < ApplicationController
  before_action :set_language, only: [:show]

  # GET /languages
  # GET /languages.json
  def index
    @languages = Language.all

    respond_to do |format|
      format.html { render html: @languages }
      format.json { render json: @languages }
    end
  end

  # GET /languages/1
  # GET /languages/1.json
  def show
    respond_to do |format|
      format.html { render html: @language }
      format.json { render json: @language }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_language
      @language = Language.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def language_params
      params[:language]
    end
end
