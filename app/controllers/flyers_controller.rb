require 'mailgun'

class FlyersController < ApplicationController
  before_filter :authenticate_user!

  # GET /flyers
  # GET /flyers.json
  def index
    
  end

  def personalize
    @template = Template.find(params[:id])
    @flyer = current_user.flyers.create(flyer_params(make_params ( @template.template_properties )))
    @flyer.save
    render 'edit'
  end

  def edit

  end

  def show
  end

  def update
    respond_to do |format|
      if flyer.update(flyer_params)
        format.html { redirect_to @flyer, notice: 'Flyer was successfully updated.' }
        format.json { render :show, status: :ok, location: @flyer }
      else
        format.html { render :edit }
        format.json { render json: @flyer.errors, status: :unprocessable_entity }
      end
    end
  end

  def send_email
    mg_client = Mailgun::Client.new Rails.application.secrets.bareed_key
    @response = mg_client.send_message 'sandbox5174d49fc72642e7831b266b19a0cbd4.mailgun.org', flyer.email_message
    @response = ActiveSupport::JSON.decode(@response.body)["message"]
    respond_to do |format|
      format.js 
      format.html { render nothing: true }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def flyer_params(args = nil)
    if [:create, :update].include? action_name
      (args || params).require(:flyer).permit(:name, :description, :content)
    end
  end

  def template_params(args = nil)
    if [:create, :update].include? action_name
      (args || params).require(:template).permit(:name, :description, :content)
    end
  end

  def template
    @template ||= TemplateDecorator.new(params[:id].present? ? Template.find(params[:id]) : Template.new(template_params) )
  end
  helper_method :template

  def templates
    @templates ||= TemplatesDecorator.new(Template.order(:updated_at).page(params[:template]), TemplateDecorator)
  end
  helper_method :templates

  def flyer
    @flyer ||= FlyerDecorator.new(params[:id].present? ? Flyer.find(params[:id]) : Flyer.new(flyer_params) )
  end
  helper_method :flyer

  def flyers
    @flyers ||= FlyersDecorator.new(Flyer.order(:updated_at).page(params[:flyer]), FlyerDecorator)
  end
  helper_method :flyers

  def make_params(template_hash)
    h = ActiveSupport::HashWithIndifferentAccess[flyer: template_hash]
    ActionController::Parameters.new(h)
  end

end
