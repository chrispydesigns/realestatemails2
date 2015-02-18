class Admin::RealtorsController < ApplicationController
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
      if realtor.save
        format.html { redirect_to [:admin, realtor], notice: 'Realtor was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    #authorize! :update, @user, :message => 'Not authorized as an administrator.'
    respond_to do |format|

      if realtor.update_attributes(realtor_params)
        format.html { redirect_to [:admin, realtor], notice: 'Realtor was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    #authorize! :destroy, @user, :message => 'Not authorized as an administrator.'

    @realtor.destroy
    respond_to do |format|
      format.html { redirect_to realtors_url }
    end
  end

  private

  def realtor
    @realtor ||= RealtorDecorator.new(params[:id].present? ? Realtor.find(params[:id]) : Realtor.new(realtor_params) )
  end
  helper_method :realtor

  def realtors
    @realtors ||= RealtorsDecorator.new(Realtor.order(:updated_at).page(params[:realtor]), RealtorDecorator)
  end
  helper_method :realtors

  def realtor_params
    if [:create, :update].include? action_name
      params.require(:realtor).permit(:email, :first_name, :last_name)
    end
  end
end
