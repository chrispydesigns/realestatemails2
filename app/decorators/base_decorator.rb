require 'delegate'

class BaseDecorator < SimpleDelegator
  include Enumerable
  
  def class
    model.class
  end

  def model
    __getobj__
  end
  
end

