class BidsController < ApplicationController
  before_action :set_item, only: [:new, :create, :approve, :decline]

  def new
    @bid = @item.bids.build
  end

  def create
    @bid = @item.bids.build(bid_params)
    @bid.user = current_user
    @bid.status = :pending
    if @bid.save
      @top_bids = @item.bids.order(amount: :desc).limit(10)
      redirect_to @item, notice: 'Bid was successfully placed.'
    else
      flash.now[:alert] = "Failed to place bid: #{@bid.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def approve
    @item = Item.find(params[:item_id])
    @bid = Bid.find(params[:id])
    @bid.update(status: 'approved')

    @item.bids.where.not(id: @bid.id).update_all(status: 'declined')

    @item.bids.where.not(id: @bid.id).destroy_all

    @item.destroy
    
    redirect_to root_path, notice: 'Bid approved successfully.'
  end

  def decline
    @bid = Bid.find(params[:id])
    @bid.update(status: 'declined')
    redirect_to root_path, notice: 'Bid declined successfully.'
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def bid_params
    params.require(:bid).permit(:amount)
  end
end
