class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.float :price, default: '0.0'
      t.string :description
      t.timestamps
    end
  end
end
