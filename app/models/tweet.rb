class Tweet
  include Neo4j::ActiveNode

  property :body
  property :date
  property :link
  property :author
  property :uid

  has_n(:companies).to("Company")

  validates_uniqueness_of :uid
end
