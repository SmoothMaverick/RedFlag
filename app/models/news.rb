class News
  include Neo4j::ActiveNode

  property :title
  property :text
  property :source
  property :link, type: String
  property :date

  has_n(:companies).to("Company")

  validates_uniqueness_of :link
end
