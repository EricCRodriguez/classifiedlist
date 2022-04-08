class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :parent, class_name: "Category", optional: true
  has_many :subcategories, class_name: "Category", foreign_key: :parent_id, dependent: :destroy
  has_many :posts

  validates_presence_of :url, :name
  # validates_presence_of :secondary_name

end
