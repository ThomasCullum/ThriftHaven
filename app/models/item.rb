class Item < ApplicationRecord
  belongs_to :user

  validates :name, :category, :description, :rating, presence: true
  validates :rating, numericality: { only_integer: true }
end
