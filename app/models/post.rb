class Post < ApplicationRecord
  belongs_to :category
  belongs_to :account
  has_many_attached :images

  validates_presence_of :account_id, :category_id

end
