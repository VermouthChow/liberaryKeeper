class Account < ApplicationRecord
  belongs_to :user

  validates :amount, :status, presence: true

  before_validation :init_amount, on: :create

  enum status: [:active, :inactive]

  DEFAULT_INIT_AMOUNT = 1

  private

  def init_amount
    self.amount = self.amount || DEFAULT_INIT_AMOUNT
  end
end
