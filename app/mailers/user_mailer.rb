class UserMailer < ApplicationMailer
	default from: 'notifications@blogit.com'

	def welcome_email(user)
		byebug
		@user = user
		@url = login_url
		mail(to: user.email, subject: 'Welcome to Blogit, the ultimate blogger')
	end

	def comment_added(post)
		@post = post
		@author = User.find(post.user_id)
		mail(to: @author.email, subject: 'New comment for your post')
	end
end
