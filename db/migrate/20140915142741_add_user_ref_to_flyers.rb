class AddUserRefToFlyers < ActiveRecord::Migration
  def change
    add_reference :flyers, :user, index: true
  end
end
