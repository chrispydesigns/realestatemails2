class Admin::StaticPagesController < ApplicationController
  before_action :set_file_name, only: [:create, :update]
  before_filter :authenticate_user!
  
  def index
  end

  def new
  end

  def show
  end

  def create
    respond_to do |format|
      if static_page.save
        format.html { redirect_to [:admin, static_page], notice: 'Static page was successfully created'}
        format.json { render :show, status: :created, location: [:admin, static_page] }
      else
        format.html { render :new }
        format.json { render json: static_page.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if static_page.update(static_page_params)
        format.html { redirect_to [:admin, @static_page], notice: 'Static Page was successfully updated.' }
        format.json { render :show, status: :ok, location: [:admin, @static_page] }
      else
        format.html { render :edit }
        format.json { render json: static_page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    static_page.destroy
    respond_to do |format|
      format.html { redirect_to admin_static_pages_url, notice: 'Static Page was successfully destroyed.' }
      format.json { head :no_content }
    end    
  end
  
  private

  def static_page
    @static_page ||= StaticPageDecorator.new( params[:id].present? ? StaticPage.find(params[:id]) : StaticPage.new(static_page_params) )
  end
  helper_method :static_page

  def static_pages
    @static_pages ||= StaticPagesDecorator.new(StaticPage.order(:updated_at).page(params[:page]), StaticPageDecorator)
  end
  helper_method :static_pages

  def set_file_name
    params[:static_page][:file_name] ||= params[:static_page][:display_name].downcase.gsub(/\s+/, '_')
  end

  def static_page_params
    if [:create, :update].include? action_name.to_sym
      params.require(:static_page).permit(:file_name, :display_name, :title_tag, :content_tag, :navigational, :layout ) 
    end
  end
end
