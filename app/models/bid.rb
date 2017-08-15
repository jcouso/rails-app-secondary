class Bid < ApplicationRecord
  belongs_to :buyer, class_name: 'User', foreign_key: :buyer_id
  belongs_to :seller, class_name: 'User', foreign_key: :seller_id
  belongs_to :security

  #validates :price, presence: true
  #validates :rate, presence: true
end
