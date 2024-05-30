class User < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_one :cart, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
