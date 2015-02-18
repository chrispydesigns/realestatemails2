class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    #authorize! :index, @user, :message => 'Not authorized as an administrator.'
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    #authorize! :create, @user, :message => 'Not authorized as an administrator.'
    respond_to do |format|
      if user.save
        format.html { redirect_to [:admin, user], notice: 'User was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    #authorize! :update, @user, :message => 'Not authorized as an administrator.'
    respond_to do |format|

      if user.update_attributes(user_params)
        format.html { redirect_to [:admin, user], notice: 'User was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    #authorize! :destroy, @user, :message => 'Not authorized as an administrator.'

    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
    end
  end

  private

  def user
    @user ||= UserDecorator.new(params[:id].present? ? User.find(params[:id]) : User.new(user_params) )
  end
  helper_method :user

  def users
    @users ||= UsersDecorator.new(User.order(:updated_at).page(params[:user]), UserDecorator)
  end
  helper_method :users

  def user_params
    if [:create, :update].include? action_name
      params.require(:user).permit(:email, :first_name, :last_name)
    end
  end
end
