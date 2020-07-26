class TransitionRecord < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :amount, :transition_time, presence: true

  enum transition_type: [:income, :refund]
end
