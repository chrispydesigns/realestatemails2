class Admin::DashboardsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @plans = Plan.order(:updated_at).page(params[:page])
    @static_pages = StaticPage.order(:updated_at).page(params[:page])
    @templates = Template.order(:updated_at).page(params[:page])
  end

end
