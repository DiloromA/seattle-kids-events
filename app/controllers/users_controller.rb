class UsersController < ApplicationController
    
    def new
        @user = User.new
    end

    def show
        @user = User.find(params[:id])
    end

    def create 
        @user = User.create(user_params)
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password_digest)
    end

end