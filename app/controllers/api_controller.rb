class ApiController < ApplicationController
	def company_search
		puts params[:term]	
		
		response = HTTParty.get("http://dnbdirect-api.dnb.com/DnBAPI-13/rest/search/company/#{params[:term]}?postBodyContentType=application%2Fjson", :headers => { "Username" => "api3322", "Password" => "welcome", "Api-Key" => "m8z88pw4899qgt8uv7w7779g"})
	
		cName  = [response["resultSet"]["hit"].first["companyResults"]["companyName"]]	
		pDuns = response["resultSet"]["hit"].first["companyResults"]["ultimateParentDuns"]

		pResponse = HTTParty.get("http://dnbdirect-api.dnb.com/DnBAPI-13/rest/company/#{pDuns}?view=simple&postBodyContentType=application%2Fjson", :headers => { "Username" => "api3322", "Password" => "welcome", "Api-Key" => "m8z88pw4899qgt8uv7w7779g"})

		pName  = [pResponse["name"]]
		#render :json => [cName, pResponse]

		render :json => { :company_name => cName, :parent_name => pName }

		# render :json => [response["resultSet"]["hit"].first["companyResults"]["companyName"], [response["resultSet"]["hit"].first["companyResults"]["ultimateParentDuns"]]	
	end
end


