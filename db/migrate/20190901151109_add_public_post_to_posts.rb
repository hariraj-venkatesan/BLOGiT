class AddPublicPostToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :public_post, :boolean, default: false
  end
end
