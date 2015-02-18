module ApplicationHelper

  def form_errors(model_instance)
    a = []
    if model_instance.errors.any?
      a = ['<div id="error explanation"', form_errors_preamble(model_instance), '<ul>']
      Rails.logger.debug "A: #{a}"
      a << model_instance.errors.full_messages.map { |message| "<li>#{message}</li>" }.join(' ')
      a << "</ul></div>"
    end
    a.join(' ').html_safe
  end
  
  def form_errors_preamble(model_instance)
    <<-eos
       <h2>#{pluralize(model_instance.errors.count, 'error')} prohibited this #{ model_instance.class.model_name.human } from being saved:</h2>
    eos
  end

  def timezone_selection(model_name)
    time_zone_select( model_name, 'time_zone', ActiveSupport::TimeZone.us_zones, :default => "Eastern Time (US & Canada)") if signed_in?
  end

end
