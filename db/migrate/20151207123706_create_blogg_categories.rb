class CreateBloggCategories < ActiveRecord::Migration
  def change
    create_table :blogg_categories do |t|
      t.integer :parent_id
      t.string :name
      t.integer :ranking

      t.timestamps null: false
    end
  end
end
