class PlansUsers < ActiveRecord::Migration
  def change
    create_table :plans_users, id: false do |t|
      t.integer :user_id
      t.integer :plan_id
    end
  end
end
