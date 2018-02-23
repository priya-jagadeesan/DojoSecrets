class SecretsController < ApplicationController

  def index
    @user = User.find(session[:user_id])
    @secrets = Secret.all
    @likes = Like.all
  end

  def new 

  end

  def create
    @secret = Secret.new(:content => params[:Content])
    @secret.user = User.find(session[:user_id])
    if @secret.save
      redirect_to "/users/#{session[:user_id]}"
    else
      flash[:has_Error] = 'has-error'
      flash[:secret] = @secret.errors
      redirect_to "/users/#{session[:user_id]}"
    end
  end

  def show 

  end
  def edit 

  end
  def update 

  end

  def destroy
    @secret = Secret.find(params[:id])
    if @secret.user == User.find(session[:user_id])
        @secret.destroy
    end
    redirect_to "/users/#{session[:user_id]}"
  end

  # private
  # def current_user
  #   User.find(session[:user_id]) if session[:user_id]
  # end
end
