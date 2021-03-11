class Image < ApplicationRecord
  validates :url,
            presence: true,
            format: { with: /https?.*\.(jpeg|jpg|gif|png)/, message: 'Not a valid image!' }
  acts_as_taggable_on :tags
end
