class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :logged_in,    :only => [:new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  
  def index
    @title = "All Users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def new
    @user = User.new
    @title = "Sign Up"
  end

  def edit
    @title = "Edit User"
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit User"
      render 'edit'
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Blather, the hottest new social network until about two weeks from now or TechCrunch gets bored!"
      redirect_to @user
    else
      @title = "Sign Up"
      render 'new'
    end
  end

  def destroy
    doomed_user = User.find(params[:id])
    unless current_user?(doomed_user)
      doomed_user.destroy
      flash[:success] = "User destroyed."
    end
    redirect_to users_path
  end

  private

    def authenticate
      deny_access unless signed_in?
    end

    def logged_in
      redirect_to(root_path) if signed_in?
    end

    def correct_user
          @user = User.find(params[:id])
          redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
  
end
