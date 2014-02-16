class Company
  include Neo4j::ActiveNode

  property :name, type: String
  property :uid, type: Integer
	property :market_cap, type: Float

  has_n(:competitors).to("Company")

  validates_uniqueness_of :uid

end
