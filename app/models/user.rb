class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :bids
  has_many :securities

  #validates :name, length: { minimum: 2 }
  #validates :email, uniqueness: true, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }, confirmation: true
  #validates :email_confirmation, presence: true
  #validates :cpf, uniqueness: true, format: { with: /[0-9]{3}[\.][0-9]{3}[\.][0-9]{3}[-][0-9]{2}/i }
  #validates :identity, uniqueness: true
  #validates :birthdate, presence: true, date: true
  #validates :mother_name, length: { minimum: 2 }
  #validates :father_name, length: { minimum: 2 }
  #validates :address, presence: true
  #validates :phone, uniqueness: true, numericality: { only_integer: true }
  #validates :bank, presence: true
  #validates :account_agency, uniqueness: true
  #validates :account_number, uniqueness: true
  #validates :expedition_date, presence: true, date: true

end
