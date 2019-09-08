class StaticPagesController < ApplicationController
  def home
  	if logged_in?
  	  @post = current_user.posts.build
  	  @feed_items = current_user.feed
  	  @feed_items = @feed_items.paginate(page: params[:page])
    end
  end
end
