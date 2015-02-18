class CreateFlyers < ActiveRecord::Migration
  def change
    create_table :flyers do |t|
      t.string :name
      t.text :description
      t.text :content

      t.timestamps
    end
  end
end
