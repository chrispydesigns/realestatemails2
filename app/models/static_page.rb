class StaticPage < ActiveRecord::Base
  extend Displayable

  before_create :set_defaults
  validates :file_name, uniqueness: true
  validates :display_name, presence: true
  
  def set_defaults
    self.file_name ||= display_name.downcase.gsub(/\s+/, '_')
    self.title_tag = display_name.capitalize if self.title_tag.blank?
    self.content_tag = title_tag if self.content_tag.blank?
    self.layout_name = 'application' if self.layout_name.blank?
  end
  
end
