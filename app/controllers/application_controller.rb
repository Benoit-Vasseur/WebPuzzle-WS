class ApplicationController < ActionController::Base
  protect_from_forgery

  #rescue_from(Exception) do |exception|
  #  #raise exception
  #  #render status:500, :json => {:error_message => exception.message}
  #end

  rescue_from Exceptions::CustomException do |exception|
    render status:500, :json => {:error_message => exception.message}
  end

  def correct_token?(auth_token=nil)
    auth_token ||= params[:auth_token] if !params['auth_token'].present?
    not User.where(github_token: auth_token).empty?
  end
end
