class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_rich_text :body

  validates_presence_of :name, :body

end
