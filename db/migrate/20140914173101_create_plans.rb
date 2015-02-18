class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.decimal :price, precision: 8, scale: 2
      t.integer :frequency
      t.integer :user_id

      t.timestamps
    end
  end
end
