class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart
  end

  def add_item
    @item = Item.find(params[:item_id])
    current_user.cart.items << @item
    redirect_to @item, notice: 'Item added to cart successfully.'
  end

  def remove_item
    @cart = current_user.cart
    if @cart
      @cart.destroy
      flash[:notice] = 'Cart was successfully cleared.'
    else
      flash[:alert] = 'No cart found for the current user.'
    end
  end

  def clear_cart
    current_user.cart.items.clear
    redirect_to cart_path, notice: 'Cart cleared successfully.'
  end
end
