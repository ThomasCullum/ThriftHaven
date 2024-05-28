class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
  end

  def index
    # if params[:query].present?
    #   @items = Item.where("name LIKE ?", "%#{params[:query]}%")
    # else
    #   @items = Item.all
    # end

    @items = Item.all
    if params[:query].present?
      sql_subquery = "name ILIKE :query OR category ILIKE :query"
      @items = @items.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def new
    @items = Item.new
  end

  def create
    @item = Item.create(item_params)
    redirect_to item_path(@items)
  end
  def edit
    @item = Item.find(params[:id])
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
