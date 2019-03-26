class Order < ApplicationRecord

  has_many :order_items

  before_save :set_sub_total

  def sub_total
    order_items.collect {|order_item| order_item.valid? ? (order_item.unit_price*order_item.quantity) : 0 }.sum
  end

  private

   def set_sub_total
     self[:sub_total] = sub_total
   end

end
