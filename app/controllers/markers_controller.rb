class MarkersController < ApplicationController
  layout false
  before_action :set_marker, only: [:show, :edit, :update, :destroy]

  # GET /markers
  # GET /markers.json
  def index
    @marker = Marker.new
  end

  # GET /markers/1
  # GET /markers/1.json
  def show
  end

  # GET /markers/new
  def new
    @marker = Marker.new
  end

  # GET /markers/1/edit
  def edit
  end

  # POST /markers
  # POST /markers.json
  def create
    file        = Marker.new
    watermarked = file.watermark(marker_params)

    send_file(watermarked)
  end

  # PATCH/PUT /markers/1
  # PATCH/PUT /markers/1.json
  def update
    respond_to do |format|
      if @marker.update(marker_params)
        format.html { redirect_to @marker, notice: 'Marker was successfully updated.' }
        format.json { render :show, status: :ok, location: @marker }
      else
        format.html { render :edit }
        format.json { render json: @marker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /markers/1
  # DELETE /markers/1.json
  def destroy
    @marker.destroy
    respond_to do |format|
      format.html { redirect_to markers_url, notice: 'Marker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_marker
    @marker = Marker.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def marker_params
    params.fetch(:marker, {})
  end
end
