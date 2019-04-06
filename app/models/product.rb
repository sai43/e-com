class Product < ApplicationRecord


  has_many :line_items, dependent: :destroy
  has_many :orders, through: :line_items

  mount_uploaders :product_images, ImageUploader

  validates :title, presence: true, length: { minimum: 2 }
  validates :product_images, file_size: { less_than: 2.megabytes }


  def self.search(search)
    where('name LIKE ?', "%#{search}%")
  end

end
