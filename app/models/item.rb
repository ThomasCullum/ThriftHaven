class Item < ApplicationRecord
  has_many :bids, dependent: :destroy
  has_and_belongs_to_many :carts
  belongs_to :user
  has_one_attached :photo
  has_many :users, through: :bids

  enum sale_type: { for_sale: 0, for_auction: 1 }

  validates :name, :category, :description, :rating, presence: true
  validates :rating, numericality: { only_integer: true }
  validates :sale_type, presence: true

  def top_bids
    bids.order(amount: :desc).limit(10)
  end
end
