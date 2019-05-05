class HomeController < ApplicationController
	def index
		friend_ids = current_user.friends.map(&:id)
		@posts = Post.posts(current_user, friend_ids)
	end
end
