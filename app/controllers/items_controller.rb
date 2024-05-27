class ItemsController < ApplicationController
  def new
    @items = Item.new
  end

  def create
    @items = Item.create(item_params)
    redirect_to item_path(@item)
  end
end
