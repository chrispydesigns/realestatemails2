class StaticPageDecorator < BaseDecorator
  
  @@non_display_fields = [:id, :created_at, :file_name]

  def display_page_attributes
    page_attributes.map { |attr| field_display_name(attr) }
  end

  def page_attributes
    attributes.keys.reject { |attr| @@non_display_fields.include?(attr) }
  end
  
  def field_display_name(field_name)
    model.class.human_attribute_name(field_name)
  end

end
