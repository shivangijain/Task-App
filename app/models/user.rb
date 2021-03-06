# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :pictures_attributes
  # devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # Association
  has_friendship
  has_many :pictures, as: :picturable
  has_many :posts
  accepts_nested_attributes_for :pictures
  acts_as_commontator


  # Validations
  validates :email, presence: true, uniqueness: true
  validates_presence_of :username

  # Scope
  scope :all_except, ->(user) { where.not(id: user.id) }

  def friend_requests
    requested_friends
  end

  def pending_requests
    pending_friends
  end
end
