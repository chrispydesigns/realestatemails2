class CreateStaticPages < ActiveRecord::Migration
  def change
    create_table :static_pages do |t|
      t.string :file_name
      t.string :display_name
      t.string :title_tag
      t.text :content_tag
      t.boolean :navigational
      t.string :layout_name

      t.timestamps
    end
    add_index :static_pages, :file_name, unique: true
  end
end
