class HomeController < ApplicationController
  skip_before_action :authorize_request, only: :index

  def index
    @products = Product.all
    # @line_item = current_order.line_items.new
  end
end
