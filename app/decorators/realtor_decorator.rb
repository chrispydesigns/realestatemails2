class RealtorDecorator < BaseDecorator

  def name
    @name ||= "#{first_name} #{last_name}"
  end

end
