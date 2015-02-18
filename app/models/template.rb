class Template < ActiveRecord::Base
  extend Displayable

  has_many :photos, as: :assetable, dependent: :destroy
  accepts_nested_attributes_for :photos, :reject_if => :all_blank, :allow_destroy => true

  def template_properties
    h = ActiveSupport::HashWithIndifferentAccess.new
    self.attributes.keys.each do |v|
      h[v] = self.send v.to_sym 
    end
    h.except(:id, :created_at, :updated_at)
  end

  def self.display_columns
    temp_display_columns.delete_if { |v| ['id', 'created_at', 'updated_at', 'content'].include?(v.to_s) }     
  end

  def self.display_column_index
    h = Hash[column_names.map.with_index.to_a]
    h.except! display_columns
  end

end
