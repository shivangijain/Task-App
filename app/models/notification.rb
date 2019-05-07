# frozen_string_literal: true

# Auto generate with notifications gem.
class Notification < ActiveRecord::Base
  include Notifications::Model
  belongs_to :user

  # Scopes
  scope :notifications, -> (user){where(user_id: user.id).order(created_at: :desc)}

  # Write your custom methods...
end
