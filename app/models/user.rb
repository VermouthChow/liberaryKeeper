class User < ApplicationRecord
  # belongs_to :role
  has_one :account

  validates :name, presence: true, length: { in: 1..30 }
  validates :sn, presence: true, uniqueness: { case_sensitive: false }
  validates :status, presence: true

  before_validation :init_sn, on: :create

  enum status: [:active, :inactive]

  private

  def init_sn
    self.sn = loop do
      random_sn = "#{ Date.current.strftime('%Y%m%d') }-#{ SecureRandom.alphanumeric(16) }"
      break random_sn unless User.exists?(sn: random_sn)
    end
  end
end
