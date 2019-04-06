class Order < ApplicationRecord

  has_many :line_items, dependent: :destroy
  belongs_to :user


  # before_save :set_sub_total

  def sub_total
    sum = 0
    line_items.each do |line_item|
      sum += line_item.total_price
    end
    sum
  end

  def self.search(search)
    where('name LIKE ?', "%#{search}%")
  end


  # def sub_total
  #   line_items.collect {|order_item| order_item.valid? ? (order_item.unit_price*order_item.quantity) : 0 }.sum
  # end
  #
  # private
  #
  #  def set_sub_total
  #    self[:sub_total] = sub_total
  #  end

end
