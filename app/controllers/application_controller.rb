class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from(Exception) do |exception|
    render status:500, :json => {:error_message => exception.message}
  end

  def correct_token?
    if params[:auth_token].present?
      not User.where(github_token: params[:auth_token].to_s).empty?
    else
      false
    end
  end
end
