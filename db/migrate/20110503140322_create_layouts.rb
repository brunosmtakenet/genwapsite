class CreateLayouts < ActiveRecord::Migration
  def self.up
    create_table :layouts do |t|
      t.string :title
      t.text :content
      t.string :image_name
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :layouts
  end
end
