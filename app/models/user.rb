class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :bids, foreign_key: :buyer_id
  has_many :selling_bids, foreign_key: :seller_id, class_name: "Bid"
  has_many :securities

  #validates :name, length: { minimum: 2 }, on: :update
  #validates :cpf, uniqueness: true, format: { with: /[0-9]{3}[\.][0-9]{3}[\.][0-9]{3}[-][0-9]{2}/i }, on: :update
  # validates :identity, uniqueness: true
  #validates :birthdate, presence: true, date: true, on: :update
  #validates :mother_name, length: { minimum: 2 }, on: :update
  #validates :father_name, length: { minimum: 2 }, on: :update
  #validates :address, presence: true, on: :update
  #validates :phone, uniqueness: true, numericality: { only_integer: true }, on: :update
  #validates :bank, presence: true, on: :update
  #validates :account_agency, uniqueness: true, on: :update
  #validates :account_number, uniqueness: true, on: :update
  #validates :document_type, presence: true, on: :update
  #validates :expedition_date, presence: true, date: true, on: :update
  #validates :document_number, presence: true, uniqueness: true, on: :update

  def my_bids_closed
    all = self.securities.map{|s| s.bids }.flatten.select{|b| b.status}
    all << Bid.where(buyer: self, status: true).to_a
    all.flatten!
  end


  def my_bids_all
    self.securities.map{|s| s.bids }.flatten
  end

  def calc_balance
    balance = self.balance.to_f
    my_bids_closed.each do |bid|
      if self == bid.buyer
        operation = bid.price + bid.comission
        balance -= operation
      else
        balance += bid.price
      end
    end
    balance
  end
end

