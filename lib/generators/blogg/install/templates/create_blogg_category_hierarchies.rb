class CreateBloggCategoryHierarchies < ActiveRecord::Migration
  def change
    create_table :blogg_category_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :blogg_category_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "blogg_category_anc_desc_idx"

    add_index :blogg_category_hierarchies, [:descendant_id],
      name: "blogg_category_desc_idx"
  end
end
