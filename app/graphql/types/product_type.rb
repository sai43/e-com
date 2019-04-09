module Types
  class ProductType < Types::BaseObject
    # name 'Product'
    field :id, ID, null: false
    field :title, String, null: false
    field :price, Float, null: false

  end
end
