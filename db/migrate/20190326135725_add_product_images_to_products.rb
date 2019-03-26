class AddProductImagesToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :product_images, :json
  end
end
