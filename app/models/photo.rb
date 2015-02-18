class Photo < ActiveRecord::Base
  extend Displayable

  attr_accessible :caption, :height, :pic, :pic_content_type, :pic_file_name, :pic_file_size, :visible, :width, :position
  belongs_to :assetable, polymorphic: true
  
  validates_attachment_presence :pic

  #paperclip
  has_attached_file :pic,
  :styles => {
    :slider => "900x400#",
    :thumb  => "300x300>",
    :small_thumb => "100x75>",
    :plan  => "400x400>" 
  }

  after_post_process :save_image_dimensions

  def save_image_dimensions
    geo = Paperclip::Geometry.from_file(pic.queued_for_write[:original])
    self.width = geo.width
    self.height = geo.height
  end
    
  Paperclip.interpolates :normalized_filename do |attachment, style|
    attachment.instance.normalized_filename
  end

  def normalized_filename
    "#{self.pic_file_name.gsub(/[\s]/, '_')}" 
  end
  
  def self.front_photo(style=nil)
    where("position = 'Front'").first.pic(style.blank? ? :slider : style)
  end
  
  def self.back_photo(style=nil)
    where("position = 'Back'").first.pic(style.blank? ? :slider : style)
  end
  
  def self.first_photo(style=nil)
    self.first.pic(style.blank? ? :slider : style)
  end

end
