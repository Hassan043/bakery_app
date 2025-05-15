class Order < ApplicationRecord
  belongs_to :user
  enum status: { pending: 0, accepted: 1, rejected: 2, completed: 3 }
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items
end
