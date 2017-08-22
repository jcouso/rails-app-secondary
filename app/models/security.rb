require 'nokogiri'
require 'open-uri'
class Security < ApplicationRecord
  belongs_to :user
  belongs_to :issuer
  belongs_to :security_type
  has_many :bids
  #validates :mode, presence: true
  #validates :code, presence: true
  #validates :maturity, presence: true
  #validates :price, presence: true, numericality: true
  #validates :date_limit, presence: true, date: true
  #validates :quantity, presence: true, numericality: true
  #validates :rate, presence: true, numericality: true
  #validates :indexer, presence: true
  #validates :unit_price, presence: true, numericality: true

  validate :maturity_cannot_be_in_the_past, on: :create
  validate :date_limit_cannot_be_in_the_past, on: :create
  validate :validate_date_limit_before_maturity, on: :create
  mount_uploader :file, FileUploader

  def value
    self.quantity * self.unit_price
  end

  def rate_in_percent
    (self.rate*100).round(2)
  end

  def future_value
    value * (rate ** )
  end

  def present_value
    future_value / (rate **)
  end

  private

  def maturity_cannot_be_in_the_past
    if maturity.present? && maturity < Date.today
      errors.add(:maturity, "Título não pode estar vencido")
    end
  end

  def date_limit_cannot_be_in_the_past
    if date_limit.present? && date_limit < Date.today
      errors.add(:date_limit, "Escolha uma data futura")
    end
  end

  def validate_date_limit_before_maturity
    if date_limit > maturity
      errors.add(:date_limit, "Título não pode ser aberto para negociação após data de vencimento")
    end
  end
end
