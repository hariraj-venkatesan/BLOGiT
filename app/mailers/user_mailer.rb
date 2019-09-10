class UserMailer < ApplicationMailer
	default from: 'do_not_reply@blogit.com'

	def welcome_email(user)
		@user = user
		mail(to: @user.email, subject: 'Welcome to Blogit, the ultimate blogger')
	end

	def comment_added(post)
		@post = post
		@author = User.find(post.user_id)
		mail(to: @author.email, subject: 'New comment for your post')
	end
end
