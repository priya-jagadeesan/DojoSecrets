class UsersController < ApplicationController
    # skip_before_action :require_login, except: [:new, :create]
    skip_before_action :require_login, only: [:new, :create]
    before_action :loggedIn, only: [:show, :edit, :update, :destroy]
    # before_action :loggedIn, except: [:index, :new, :create]

    def index

    end

    def new
        
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to '/sessions/new'
        else
            flash[:error] = @user.errors
            redirect_to '/users/new'
        end
    end

    def show
        @user = User.find(session[:user_id])
    end

    def edit
        @user = User.find(session[:user_id])
    end

    def update
        @user = User.find(params[:id])
        # @user.update_attributes(email: params[:email],name: params[:name])
        # Rails.logger.info(@user.inspect)
        # if @user.valid?
        if @user.update_attributes(email: params[:email],name: params[:name])
            redirect_to "/users/#{@user.id}"
        else
            # Rails.logger.info(@user.errors.messages.inspect)
            redirect_to "/users/#{@user.id}/edit"
        end
    end

    def destroy
        @user = User.find(session[:user_id])
        @user.destroy
        session[:user_id] = nil
        redirect_to '/users/new'
    end

    private
    def user_params
        params.require(:user).permit(:email,:name,:password,:password_confirmation)
    end

    def loggedIn
        if session[:user_id]
            if (session[:user_id] == params[:id])
                puts 'here'
                redirect_to "/users/#{session[:user_id]}"
            end
        end
    end
end
