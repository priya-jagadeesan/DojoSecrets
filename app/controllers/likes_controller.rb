class LikesController < ApplicationController

  def index 

  end

  def new 

  end

  def create
    @user = User.find(session[:user_id])
    @secret = Secret.find(params[:id])
    @like = Like.new(user: @user, secret: @secret)
    if @like.save
      @unlike = true
      redirect_to "/secrets"
    else
      @like = true
      flash[:error] = @like.errors
      redirect_to "/secrets"
    end
  end

  def show 

  end
  def edit 

  end
  def update 

  end

  def destroy
    @user = User.find(session[:user_id])
    @secret = Secret.find(params[:id])
    @like = Like.find_by(user: @user, secret: @secret)
    @like.destroy
    @like = true
    redirect_to "/secrets"
  end
end
