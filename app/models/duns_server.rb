class DunsServer
	include Neo4j::ActiveNode
  def self.company_search(term)
		#query company name and company id
		response = HTTParty.get("http://dnbdirect-api.dnb.com/DnBAPI-13/rest/search/company/#{term}?postBodyContentType=application%2Fjson", :headers => { "Username" => "api3322", "Password" => "welcome", "Api-Key" => "m8z88pw4899qgt8uv7w7779g"})
	
		cName  = response["resultSet"]["hit"].first["companyResults"]["companyName"]	
		cId  = response["resultSet"]["hit"].first["companyResults"]["companyId"]	
		
		Company.create(name:cName,uid:cId)
	
		#query company news

		#query competititors

		#query competitor news

  end
end
