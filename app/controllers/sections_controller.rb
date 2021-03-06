class SectionsController < ApplicationController
  include DataUrlConcern

  before_action :set_section, only: [:show, :edit, :update, :destroy]

  # GET /sections
  # GET /sections.json
  def index
    @sections =  params[:path].nil? ? Section.all : Section.where(path: params[:path])

    respond_to do |format|
      format.html { render html: @sections }
      format.json { render json: @sections }
    end
  end

  # GET /sections/1
  # GET /sections/1.json
  def show
    respond_to do |format|
      format.html { render html: @section }
      format.json { render json: @section }
    end
  end

  # GET /sections/new
  def new
    @section = Section.new
  end

  # GET /sections/1/edit
  def edit
  end

  # POST /sections
  # POST /sections.json
  def create
    @section = Section.new(section_params)

    respond_to do |format|
      if @section.save
        format.html { redirect_to @section, notice: 'Section was successfully created.' }
        format.json { render json: @section }
      else
        format.html { render action: 'new' }
        format.json { render json: ErrorSerializer.serialize(@section.errors), status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sections/1
  # PATCH/PUT /sections/1.json
  def update
    respond_to do |format|
      if @section.update(section_params)
        format.html { redirect_to @section, notice: 'Section was successfully updated.' }
        format.json { render json: @section }
      else
        format.html { render action: 'edit' }
        format.json { render json: ErrorSerializer.serialize(@section.errors), status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.json
  def destroy
    @section.destroy
    respond_to do |format|
      format.html { redirect_to sections_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def section_params
      if params[:section] && params[:section][:background]
        background_params = params[:section][:background]

        params[:section][:background] = convert_to_file(background_params)
      end
      params.require(:section).permit(:path, :background)
    end
end
