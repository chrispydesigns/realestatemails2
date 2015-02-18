class Plan < ActiveRecord::Base
  extend Displayable
  
  has_and_belongs_to_many :users, join_table: :plans_users

end
