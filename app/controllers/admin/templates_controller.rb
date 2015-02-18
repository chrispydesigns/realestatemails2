class Admin::TemplatesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  end

  def new
  end

  def show
  end

  def create
    respond_to do |format|
      if template.save
        format.html { redirect_to [:admin, template], notice: 'Template was successfully created'}
        format.json { render :show, status: :created, location: [:admin, template] }
      else
        format.html { render :new }
        format.json { render json: template.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if template.update(template_params)
        format.html { redirect_to [:admin, template], notice: 'Template was successfully updated.' }
        format.json { render :show, status: :ok, location: [:admin, template] }
      else
        format.html { render :edit }
        format.json { render json: template.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    template.destroy
    respond_to do |format|
      format.html { redirect_to admin_templates_url, notice: 'Static Page was successfully destroyed.' }
      format.json { head :no_content }
    end    
  end
  
  private

  def template
    @template ||= TemplateDecorator.new(params[:id].present? ? Template.find(params[:id]) : Template.new(template_params) )
  end
  helper_method :template

  def templates
    @templates ||= TemplatesDecorator.new(Template.order(:updated_at).page(params[:template]), TemplateDecorator)
  end
  helper_method :templates

  def template_params
    if [:create, :update].include? action_name
      params.require(:template).permit(:name, :description, :content)
    end
  end

end
