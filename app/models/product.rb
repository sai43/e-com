class Product < ApplicationRecord

  has_many :order_items

  mount_uploaders :product_images, ImageUploader

  validates :title, presence: true, length: { minimum: 2 }
  validates :product_images, file_size: { less_than: 2.megabytes }


end
