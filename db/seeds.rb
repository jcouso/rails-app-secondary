# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


SECURITY_TYPES = ["CDB", "CRA", "CRI", "DEB", "DPGE", "FIDC", "LC", "LCA", "LCI", "LF", "LFSUB"]

INDEXERS = ["CDI", "PRE", "IPC-A+", "IGP-M+"]

ISSUERS = ["Bradesco", "Banco do Brasil", "Banco Original", "Banco BMG", "Vale"]

DOCUMENT_TYPES = ["RG", "CNH", "Passaporte"]

SECURITY_TYPES.each do |securiry_type|
  SecurityType.create(name:securiry_type)
end

ISSUERS.each do |issuer|
  Issuer.create(name:issuer)
end

10.times do
  u = User.create(email: Faker::Internet.email,
              password: "123123",
              name: Faker::Name.name,
              cpf: Faker::Number.number(11),
              document_type: DOCUMENT_TYPES.sample,
              document_number: Faker::Number.number(7),
              expedition_date: Faker::Date.birthday,
              birthdate: Faker::Date.birthday,
              mother_name:Faker::Name.name,
              father_name:Faker::Name.name,
              # identity: "RG",
              address: Faker::Address.street_address,
              phone: Faker::PhoneNumber.phone_number,
              bank: ISSUERS.sample,
              account_agency: Faker::Address.street_name,
              account_number: Faker::Number.number(10)
              )

  10.times do
  quantity = rand(1..30)
  unit_price = rand(1000.00..1500.00)
  Security.create(user: u,
                issuer: Issuer.all.sample,
                security_type: SecurityType.all.sample,
                mode: "Leilão",
                code: Faker::Number.number(8),
                maturity: Faker::Date.forward(rand(365..1200)),
                issue_date: Faker::Date.backward(rand(1..720)),
                date_limit: Faker::Date.forward(14),
                quantity: quantity = rand(1..30),
                rate: rand(0.10...0.15),
                unit_price: unit_price,
                price: quantity*unit_price*rand(1...1.10),
                indexer: INDEXERS.sample
                )
  end
end




Security.all.each do |security|
  rand(3...7).times do
    Bid.create(
               buyer: User.all.select { |buyer| buyer  != security.user }.sample,
               seller: security.user,
               security: security,
               status: false,
               price: security.quantity*security.unit_price*rand(0.80..1.20),
               indexer: INDEXERS.sample)
  end
end
