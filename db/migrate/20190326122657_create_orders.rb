class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :status  #[Ordered and Approved, Delivered, Return, Return Approved, Pickup, Refund]
      t.string :description
      t.string :pay_method, default: '$'
      t.timestamps
    end
  end
end
