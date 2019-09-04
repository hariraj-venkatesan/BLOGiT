class SharedPostsController < ApplicationController
  def new
  	@post = Post.find(params[:post])
  	@shared_post = SharedPost.new
  end

  def create
  	params[:shared_post][:id].each do |reader_id|
  		SharedPost.create!(author: current_user, post: Post.find(params[:post_id]), reader: User.find(reader_id))
	end
	redirect_to current_user
  end

  def destroy
  end
end
