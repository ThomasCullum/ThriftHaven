class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true

  enum status: { pending: 0, approved: 1, declined: 2 }

  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= :pending
  end
end
