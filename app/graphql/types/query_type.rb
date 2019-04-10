module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :products, [ProductType], null: false

    def products
      Product.all
    end

  end
end
