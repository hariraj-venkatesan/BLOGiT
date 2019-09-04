class CreateSharedPosts < ActiveRecord::Migration
  def change
    create_table :shared_posts do |t|
      t.integer :author_id
      t.integer :post_id
      t.integer :reader_id

      t.timestamps null: false
    end
    add_index :shared_posts, [:author_id, :post_id, :reader_id]
  end
end
