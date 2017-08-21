class Search
  include ActiveModel::Model

  attr_accessor :price, :maturity, :issuer_id, :rate, :indexer, :security_type_id
end
