class Product < ApplicationRecord
  belongs_to :category
  has_many_attached :images

  scope :by_name,     ->(q) { where("name ILIKE ?", "%#{q}%") if q.present? }
  scope :by_category, ->(c) { where(category_id: c)        if c.present? }
end
