class UsersController < ApplicationController
  before_action :require_user_logged_in,only: [:index, :show,:likes]
  
  def index
      @users = User.all.page(params[:page])
  end

  def show
    @user= User.find(params[:id])
    @micropost =current_user.microposts.build
    @microposts = @user.microposts.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user =User.new(user_params)#プライベートなメソッド
    
    if @user.save
      flash[:success] ='ユーザーを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] ='ユーザーの登録に失敗しました。'
      render :new
    end
  end

 def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
 end

 def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
 end
 
 def likes
    @user = User.find(params[:id])
    @microposts = @user.favorites.page(params[:page])
     counts(@user)
 end


private
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

#この password から暗号化され password_digest として保存されます。password_confirmation は password の確認のために使用されます。
end
