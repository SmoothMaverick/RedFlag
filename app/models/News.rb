class News
  include Neo4j::ActiveNode

  property :title
  property :text
  property :source
  property :link
  property :date

  has_n(:companies).to("Company")

end
