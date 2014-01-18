class UploadsController < ApplicationController
  before_filter { raise Exceptions::CustomException.new(I18n.t('authentication.notoken')) if((request.post? || request.put? || request.delete?) && (!params[:auth_token].present? || !correct_token?(params[:auth_token])))}

  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.all
    render json: @uploads
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
    @upload = Upload.find_by_id(params[:id])

    render json: @upload
  end

  # GET /uploads/new
  # GET /uploads/new.json
  def new
    @upload = Upload.new
    render json: @upload
    render html: @upload['images']['medium']
  end

  # GET /uploads/1/edit
  def edit
    @upload = Upload.find(params[:id])
  end

  # POST /uploads
  # POST /uploads.json
  def create
    @upload = Upload.new(params[:upload])

    if @upload.save
        render json: {id:@upload.id, images:@upload.images}, status: :created
      else
        render json: @upload.errors, status: :unprocessable_entity
    end
  end

  # PUT /uploads/1
  # PUT /uploads/1.json
  def update
    @upload = Upload.find_by_id(params[:id])

    respond_to do |format|
      if @upload.update_attributes(params[:upload])
        format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end
end
