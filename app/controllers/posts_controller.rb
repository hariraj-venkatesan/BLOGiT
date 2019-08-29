class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
    
  end

  # # PATCH/PUT /posts/1
  # # PATCH/PUT /posts/1.json
  # def update
  #   respond_to do |format|
  #     if @post.update(post_params)
  #       format.html { redirect_to @post, notice: 'Post was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @post }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @post.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
