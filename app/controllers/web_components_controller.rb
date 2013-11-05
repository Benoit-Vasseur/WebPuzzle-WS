class WebComponentsController < ApplicationController
  before_filter { |controller| session['last_action'] = {'controller'=>controller.controller_name, 'action'=>controller.action_name }   }
  before_filter {raise Exceptions::CustomException.new(I18n.t('authentication.notoken')) if((request.post? || request.put? || request.delete?) && !correct_token?)}

  # GET /web_components
  # GET /web_components.json
  def index
      @web_components = WebComponent.all
      render json: @web_components
  end

  # GET /web_components/1
  # GET /web_components/1.json
  def show
    @web_component = WebComponent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @web_component }
    end
  end

  # GET /web_components/new
  # GET /web_components/new.json
  def new
    @web_component = WebComponent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @web_component }
    end
  end

  # GET /web_components/1/edit
  def edit
    @web_component = WebComponent.find(params[:id])
  end

  # POST /web_components
  # POST /web_components.json
  def create
    @web_component = WebComponent.new(params[:web_component])

    respond_to do |format|
      if @web_component.save
        format.html { redirect_to @web_component, notice: 'Web component was successfully created.' }
        format.json { render json: @web_component, status: :created, location: @web_component }
      else
        format.html { render action: "new" }
        format.json { render json: @web_component.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /web_components/1
  # PUT /web_components/1.json
  def update
    @web_component = WebComponent.find(params[:id])

    respond_to do |format|
      if @web_component.update_attributes(params[:web_component])
        format.html { redirect_to @web_component, notice: 'Web component was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @web_component.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /web_components/1
  # DELETE /web_components/1.json
  def destroy
    @web_component = WebComponent.find(params[:id])
    @web_component.destroy

    respond_to do |format|
      format.html { redirect_to web_components_url }
      format.json { head :no_content }
    end
  end
end
