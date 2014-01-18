class WebComponentsController < ApplicationController
  respond_to :json

  before_filter { |controller| session['last_action'] = {'controller'=>controller.controller_name, 'action'=>controller.action_name }   }
  before_filter { raise Exceptions::CustomException.new(I18n.t('authentication.notoken')) if((request.post? || request.put? || request.delete?) && (!params[:auth_token].present? || !correct_token?(params[:auth_token])))}
  before_filter  :check_type, only: [:index, :create]

  def check_type
    types_accepted = %W(AngularJsWc AngularDartWc JqueryWc EmberWc PolymerJsWc PolymerDartWc)
    raise Exceptions::CustomException.new(I18n.t('webcomponent.validtype')) if !types_accepted.include?(params[:type])
  end

  def web_component_url(web_component)
    "http://#{request.host_with_port}/web_component/#{web_component.id}.json"
  end

  # GET /web_components/:type.json
  def index
    @web_components = WebComponent.find_all_by_type(params[:type])
    respond_with @web_components
  end

  # GET /web_component/:id.json
  def show
    @web_component = WebComponent.find_by_id(params[:id])
    if !@web_component.nil?
      respond_with @web_component
    else
      render json:{}
    end
  end

  # POST /web_component/:type.json
  def create
    typeWC = params[:type]
    @web_component = WebComponent.new(params[:web_component])
    @web_component.type = typeWC

    #User must be in db cause before_filter did the job of checking he exists
    @web_component.submitter = User.find_by_github_token(params[:auth_token])

    if @web_component.save
      respond_with @web_component.serializable_hash, status: :created, location: @web_component
    else
      respond_with @web_component, status: :unprocessables_entity
    end
  end

  # PUT /web_component/1.json
  def update
    @web_component = WebComponent.find_by_id(params[:id])

    if @web_component.nil?
      render status: 404, json: {status:404, error_message: I18n.t('generic.unknownentity')}
    end

    if @web_component.update_attributes(params[:web_component])
      head :no_content
    else
      respond_with @web_component, status: :unprocessable_entity
    end
  end

  # DELETE /web_components/1.json
  def destroy
    raise Exceptions::CustomException.new(I18n.t('webcomponent.deletionnotimpl'))
  end
end
