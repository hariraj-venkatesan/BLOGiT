class CommentsController < ApplicationController
	def new
		create
	end

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(comment_params)
		@comment.user_id = params[:comment][:comment_anonymously] == '1' ? nil : current_user.id
		if @comment.save
			flash[:success] = "Comment added"
		else
			flash[:danger] = "Comment cannot be empty"
		end
		redirect_to post_path(@post)
	end

	private
	def comment_params
		params.require(:comment).permit(:body)
	end
end
