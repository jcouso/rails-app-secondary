class Search
  include ActiveModel::Model

  attr_accessor :price, :maturity, :issuer_id, :rate, :indexer, :security_type_id

  def empty?
    !present?
  end

  def present?
    price.present? || maturity.present? || issuer_id.present? || rate.present? || indexer.present? || security_type_id.present?
  end
end
