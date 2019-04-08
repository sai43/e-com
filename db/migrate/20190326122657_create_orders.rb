class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :status , default: 'Created'
      t.string :description
      t.string :pay_method, default: '$'
      t.timestamps
    end
  end
end
