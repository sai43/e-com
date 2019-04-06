class LineItem < ApplicationRecord

  belongs_to :product
  belongs_to :cart


  def total_price
    if valid_quantity_and_price?
      quantity.to_s.to_d * product.price.to_s.to_d
    else
      0.0
    end
  end

  def valid_quantity_and_price?
    !quantity.to_s.strip.empty? && !product.price.to_s.strip.empty?
  end

  # before_save :set_unit_price, :set_total_price
  #
  # def unit_price
  #   if persisted?
  #     self[:unit_price]
  #   else
  #     # product.price
  #   end
  # end
  #
  # def total_price
  #   unit_price * quantity
  # end
  #
  # private
  #
  # def set_unit_price
  #   self[:unit_price] = unit_price
  # end
  #
  # def set_total_price
  #   self[:total_price] = quantity * set_unit_price
  # end

end
