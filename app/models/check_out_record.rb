class CheckOutRecord < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum status: [:lend, :return]
end
