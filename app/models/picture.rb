# frozen_string_literal: true

class Picture < ApplicationRecord
  belongs_to :picturable, polymorphic: true
  has_attached_file :image
  validates_attachment_content_type :image, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
end
