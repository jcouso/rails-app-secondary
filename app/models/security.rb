class Security < ApplicationRecord
  belongs_to :user
  belongs_to :issuer
  belongs_to :security_type
  has_many :bids
  validate :user, presence: true, uniqueness: true
  validates :issuer, presence: true, uniqueness: true
  validates :secutity_type, presence: true, uniqueness: true
  validates :status, presence: true
  validates :mode, presence: true
  validates :code, presence: true
  validates :maturity, presence: true
  validates :price, presence: true, numericality: true
  validates :date_limit, presence: true, date: true
  validates :status, presence: true, date: true
  validates :quantity, presence: true, numericality: true { only_integer: true }
  validates :rate, presence: true, numericality: true
  validates :indexer, presence: true
  validates :unit_price, presence: true, numericality: true

  def self.value
    self.quantity * self.unit_price
  end

end
