class DispatcherController < ApplicationController
  before_filter :authenticate_user!

  def start
  end

  def send_email
  end

  private

  def current_agent
    @current_agent ||= UserDecorator.new( current_user ) if current_user.present?
  end
  helper_method :current_agent

end
