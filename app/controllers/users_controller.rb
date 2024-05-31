class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all


    @sold_items = Item.where(sold: true)
    @total_sold_value = @sold_items.sum(:price)

    @earnings_over_time = Item.where(sold: true).group_by_month(:created_at, format: "%b %Y", last: 12).sum(:price).map do |month, earnings|
      { month: month, earnings: earnings }
    end

    @bought_items_count = Item.where(bought: true).count
    @views_count = Item.sum(:views)

    @category_data = {
      'Tops' => Item.where(category: 'Tops').count,
      'Bottoms' => Item.where(category: 'Bottoms').count,
      'Accessories' => Item.where(category: 'Accessories').count
    }

    @items= Item.joins(:bids).distinct
  end

  def show
    @user = User.find(params[:id])
    @cart = @user.cart
    @item = @user.items.first
  end

  def remove_from_cart
    @user = current_user
    @item = Item.find(params[:item_id])
    @user.cart.items.delete(@item)
    redirect_to @item, notice: 'Item removed from cart successfully.'
  end

  private

  def calculate_earnings_over_time
    earnings = []
    (1..12).each do |month|
      start_date = Date.new(Date.today.year, month, 1)
      end_date = start_date.end_of_month
      monthly_earnings = Item.where(sold: true, sold_at: start_date..end_date).sum(:price)
      earnings << { month: start_date.strftime('%b'), earnings: monthly_earnings }
    end
    earnings
  end

  def set_user
    @user = User.find(params[:id])
  end
end
