class PlayersController < ApplicationController
  include UserAttributesConcern
  include PersonAttributesConcern

  # TODO: investigate further, why resource-loading doesn't work as expected w/ cancancan on create
  load_resource except: :create
  authorize_resource
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  # GET /players
  # GET /players.json
  def index
    @players = Player.all

    respond_to do |format|
      format.html { render html: @players }
      format.json { render json: @players }
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
    respond_to do |format|
      format.html { render html: @player }
      format.json { render json: @player }
    end
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render json: @player }
      else
        format.html { render action: 'new' }
        format.json { render json: ErrorSerializer.serialize(@player.errors), status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render json: @player }
      else
        format.html { render action: 'edit' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params_hash = params.require(:player)

      result = {
        card_number: params_hash.delete(:card_number),
        id_type: params_hash.delete(:id_type),
        id_number: params_hash.delete(:id_number),
        date_of_birth: params_hash.delete(:date_of_birth),
        user_attributes: fetch_user_attributes(params_hash),
        person_attributes: fetch_person_attributes(params_hash)
      }

      return result
    end
end
