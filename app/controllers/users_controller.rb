class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    @user = current_user
    @cart = @user.cart
  end

  def remove_from_cart
    @user = current_user
    @item = Item.find(params[:item_id])
    @user.cart.items.delete(@item)
    redirect_to @item, notice: 'Item removed from cart successfully.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
