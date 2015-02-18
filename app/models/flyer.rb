class Flyer < ActiveRecord::Base
  extend Displayable

  belongs_to :user
  validates_presence_of :user_id

  has_many :photos, as: :assetable, dependent: :destroy
  accepts_nested_attributes_for :photos, :reject_if => :all_blank, :allow_destroy => true

end
