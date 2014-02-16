class Company
  include Neo4j::ActiveNode

  property :name, type: String
  property :uid, type: String

  has_n(:competitors).to("Company")

end
