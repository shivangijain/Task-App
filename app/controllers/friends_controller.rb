# frozen_string_literal: true

class FriendsController < ApplicationController
  before_action :find_user, only: %i[add_friend accept_friend cancel_friend show]

  def index
    @all_friends = current_user.friends
  end

  def show
    @posts = if current_user.friends_with?(@friend) || @friend == current_user
               @friend.posts.order(updated_at: :desc)
             else
               Post.non_friend_posts(@friend)
             end
  end

  def suggestions
    @suggestions = User.all_except(current_user)
  end

  def requests
    @all_requests = current_user.friend_requests
  end

  def notification
    @notifications = Notification.where(user_id: current_user.id)
  end

  def add_friend
    current_user.friend_request(@friend)
    flash[:notice] = 'Friend Request is succefully send'
    redirect_to suggestions_friends_path
  end

  def cancel_friend
    current_user.decline_request(@friend)
    flash[:notice] = 'Friend Request is succefully cancelled'
    redirect_to suggestions_friends_path
  end

  def accept_friend
    current_user.accept_request(@friend)
    flash[:notice] = 'Friend Request is accepted successfully'
    redirect_to requests_friends_path
  end

  private

  def find_user
    @friend = User.find_by(id: params[:id])
  end
end
