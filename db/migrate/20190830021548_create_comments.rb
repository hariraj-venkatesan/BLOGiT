class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      # t.string :commenter
      t.references :user, index: true
      t.text :body
      # t.references :post, index: true, foreign_key: true
      t.belongs_to :post, index: true

      t.timestamps null: false
    end
  end
end
