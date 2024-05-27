class Item < ApplicationRecord
  belongs_to :user
<<<<<<< HEAD

  validates :name, :category, :description, :rating, presence: true
  validates :rating, numericality: { only_integer: true }
=======
>>>>>>> master
end
