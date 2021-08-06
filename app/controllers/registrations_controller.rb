class RegistrationsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Object successfully created"
            redirect_to root_path 
        else
            if @user.errors.any?
                flash.now[:alert] = @user.errors.full_messages.first
            else
                flash.now[:alert] = "Something went wrong"
            end
            render 'new'
        
        end
    end
    
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
    
end
