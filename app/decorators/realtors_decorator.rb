class RealtorsDecorator < CollectionDecorator
  delegate :current_page, :total_pages, :limit_value, to: :object
  delegate :display_columns, to: :object_class

end
