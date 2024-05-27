class ItemsController < ApplicationController
  def edit
    @items = Item.find(params[:id])
  end

  def update
    @item = item.find(params[:id])
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_item
    @item = item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :rating, :category)
  end
end
