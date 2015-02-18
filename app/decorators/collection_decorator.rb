class CollectionDecorator
  attr_reader :object
  attr_reader :object_class
  attr_reader :decorator
  
  array_methods = Array.instance_methods - Object.instance_methods
  delegate :==, :as_json, *array_methods, to: :decorated_collection
  
  def initialize(collection, decorator)
    @object = collection
    @decorator = decorator
    @object_class = collection.model
  end
  
  def decorated_collection
    @decorated_collection ||= object.map { |item| decorator.new item }
  end
  
end
  
