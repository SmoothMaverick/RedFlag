class DunsServer
  def company_search(term)
		response = HTTParty.get("http://dnbdirect-api.dnb.com/DnBAPI-13/rest/search/company/#{term}?postBodyContentType=application%2Fjson", :headers => { "Username" => "api3322", "Password" => "welcome", "Api-Key" => "m8z88pw4899qgt8uv7w7779g"})
	
		cName  = [response["resultSet"]["hit"].first["companyResults"]["companyName"]]	
		cId = response["resultSet"]["hit"].first["companyResults"]["companyId"]
		
		Company.create(name:cName,uuid:cId)
  end
end
