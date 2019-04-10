module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :price, Float, null: false
    # field [:product_images, [ProductImageType]], null: true
  end
end
