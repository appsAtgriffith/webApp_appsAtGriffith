class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    check_authorization :unless => :devise_controller?
    # rescue_from CanCan::AccessDenied do |exception|
    #     redirect_to root_url, :alert => exception.message
    # end

    def index

    end

    protect_from_forgery with: :exception

end
