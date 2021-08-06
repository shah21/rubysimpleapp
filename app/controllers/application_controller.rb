class ApplicationController < ActionController::Base
    before_action :set_current_user

    def set_current_user
        Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def require_user_is_logged_in
        unless Current.user
            redirect_to login_path, alert: 'You must be signed in'
        end
    end
end
