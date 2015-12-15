class CreateBloggPosts < ActiveRecord::Migration
  def change
    create_table :blogg_posts do |t|
      t.string :title
      t.text :description
      t.boolean :draft
      t.datetime :publish_at

      t.timestamps null: false
    end
  end
end
