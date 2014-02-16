class ApiController < ApplicationController
	def company_search
		response = HTTParty.get("http://dnbdirect-api.dnb.com/DnBAPI-13/rest/search/company/pepsi?postBodyContentType=application%2Fjson", :headers => { "Username" => "api3322", "Password" => "welcome", "Api-Key" => "m8z88pw4899qgt8uv7w7779g"})
		render :json => ["company1", "company2", "company3"]

	end
end


