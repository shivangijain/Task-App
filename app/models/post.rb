# frozen_string_literal: true

class Post < ApplicationRecord
  after_commit :create_notifications, on: [:create]
  belongs_to :user
  has_many :pictures, as: :picturable
  accepts_nested_attributes_for :pictures
  acts_as_commontable dependent: :destroy

  # Scopes
  default_scope -> { where(deleted: false) }
  scope :posts, ->(user, friend_ids) { where('user_id IN (?) OR user_id = ? OR public = ?', friend_ids, user.id, true).order(updated_at: :desc) }
  scope :non_friend_posts, ->(friend_id) { where(user_id: friend_id, public: true).order(updated_at: :desc) }

  def create_notifications
    user.friends.each do |friend|
      Notification.create(
        notify_type: 'comment',
        actor: user,
        user: friend,
        target: self
      )
    end
  end
end
