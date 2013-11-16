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
    puts 'params ' + params.inspect
    auth_token = params[:auth_token] if params[:auth_token].present?
    puts auth_token    + 'test'
    puts User.where(github_token: auth_token).empty?
    not User.where(github_token: auth_token).empty?
  end
end
