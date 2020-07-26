class Book < ApplicationRecord
  belongs_to :group, optional: true 
  belongs_to :series_book, optional: true

  has_many :transition_records
  has_many :income_transition_records, -> { income }, class_name: "TransitionRecord"
  has_many :check_out_records
  has_one :current_check_out, -> { lend.order('check_out_records.created_at DESC') }, class_name: "CheckOutRecord"

  validates :name, :author, :rent, :isbn, presence: true

  before_validation :init_rent, on: :create

  enum status: [:active, :inactive, :discarded]

  scope :check_out, ->{ joins(:current_check_out) }
  scope :available, ->{ left_joins(:current_check_out).where('check_out_records.id IS NULL') }

  DEFAULT_RENT = 10

  class << self
    def total_rent
      sum(:rent)
    end
  end

  def rented?
    current_check_out.present?
  end

  private

  def init_rent
    self.rent = self.rent || DEFAULT_RENT
  end
end
