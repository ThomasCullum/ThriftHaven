class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy, :add_to_cart, :place_bid]

  def show
    @item = Item.find(params[:id])
    @top_bids = @item.bids.order(amount: :desc).limit(10)
    @bid = Bid.new if @item.for_auction?
  end

  def accept_bid
    @item = Item.find(params[:id])
    @bid = @item.bids.find(params[:id])


    if @bid.update(status: 'approved')
      @item.update(sold: true, user_id: @bid.user_id)

      @item.bids.where.not(id: @bid.id).update_all(status: 'declined')

      @item.bids.where.not(id: @bid.id).destroy_all

      @item.destroy

      flash[:notice] = "Bid accepted. Notification sent to #{@bid.user.first_name}."

      redirect_to items_path
    else
      flash[:alert] = "Failed to accept bid."
      redirect_to items_path
    end
  end

  def decline_bid
    @item = Item.find(params[:id])
    @bid = @item.bids.find(params[:bid_id])

    if @bid.update(status: 'declined')
      flash[:notice] = "Bid declined."
      redirect_to items_path
    else
      flash[:alert] = "Failed to decline bid."
      redirect_to items_path
    end
  end

  def add_to_cart
    @user = current_user
    @item = Item.find(params[:id])

    @user.create_cart unless @user.cart

    @user.cart.items << @item

    redirect_to @item, notice: 'Item added to cart successfully.'
  end

  def checkout
    @user = current_user
    @cart = @user.cart

    if @cart && @cart.items.any?
      redirect_to root_path, notice: 'Your order has been placed. It will be shipped soon.'
      @cart.items.clear
    else
      redirect_to cart_path, alert: 'Your cart is empty. Please add items before checking out.'
    end
  end

  def remove_from_cart
    @user = current_user
    @cart = @user.cart

    if @cart && @cart.items.delete(@item)
      redirect_to @item, notice: 'Item removed from cart successfully.'
    else
      redirect_to @item, alert: 'Failed to remove item from cart.'
    end
  end

  def place_bid
    @item = Item.find(params[:id])
    @bid = Bid.new(bid_params)
    @bid.item = @item
    @bid.user = current_user

    if @bid.save
      redirect_to @item, notice: 'Bid was successfully placed.'
    else
      render :show
    end
  end

  def index
    @items = Item.all
    if params[:query].present?
      sql_subquery = "name ILIKE :query OR category ILIKE :query"
      @items = @items.where(sql_subquery, query: "%#{params[:query]}%")
    end
    @users = User.joins(:bids).distinct

    @earnings_over_time = Item.group_by_month(:created_at, format: "%b").sum(:price).map do |month, earnings|
      { month: month, earnings: earnings }
    end
  end

  def new
    @item = Item.new
  end

  def create
    # @item = current_user.items.new(item_params)
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render :new
    end



  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to items_url, notice: 'Item was successfully destroyed.'
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :rating, :category, :price, :sale_type, :photo)
  end

  def bid_params
    params.require(:bid).permit(:amount)
  end

end
