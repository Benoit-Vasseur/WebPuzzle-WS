class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Exception,                            :with => :render_error
  rescue_from ActiveRecord::RecordNotFound,         :with => :render_not_found
  rescue_from ActionController::RoutingError,       :with => :render_not_found
  rescue_from ActionController::UnknownController,  :with => :render_not_found
  rescue_from AbstractController::ActionNotFound,      :with => :render_not_found

  def render_not_found
    render status:404, :json => { :status=>404, :error_message => I18n.t('generic.unknownentity')}
  end

  def render_error(exception)
    render status:500, :json => {:status=>500, :error_message => exception.message}
  end

  def correct_token?(auth_token=nil)
    auth_token = params[:auth_token] if params[:auth_token].present?
    not User.where(github_token: auth_token).empty?
  end
end
