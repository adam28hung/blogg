class CreateBloggArticles < ActiveRecord::Migration
  def change
    create_table :blogg_articles do |t|
      t.text :content
      t.string :editable_type
      t.integer :editable_id

      t.timestamps null: false
    end
  end
end
