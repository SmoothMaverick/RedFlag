class Company
  include Neo4j::ActiveNode

  property :name, type: String
  property :uid, type: Integer

  has_n(:competitors).to("Company")

  validates_uniqueness_of :uid

end
