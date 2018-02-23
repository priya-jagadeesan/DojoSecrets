class SessionsController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]
    # before_action :require_login, except: [:new, :create]

    def index

    end

    def new

    end

    def create
        if !params[:user][:password]
            flash[:error] = {'Login' => ["Invalid Credentials"] }
        elsif !params[:user][:email]
            flash[:error] = {'Login' => ["Invalid Credentials"] }
        end
        @user = User.find_by_email(params[:user][:email]).try(:authenticate, params[:user][:password])
        if @user
            session[:user_id] = @user.id
            redirect_to "/users/#{@user.id}"
        else
            flash[:error] = {'Login' => ["Invalid Credentials"] }
            redirect_to '/sessions/new'
        end
    end

    def show

    end

    def edit

    end

    def update

    end

    def destroy
        session[:user_id] = nil
        redirect_to '/sessions/new'
    end

    private
    def user_params
        params.require(:user).permit(:email,:password)
    end
end
