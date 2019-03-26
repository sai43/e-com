class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.float :sub_total
      t.float :total
      t.string :shipping_status

      t.timestamps
    end
  end
end
