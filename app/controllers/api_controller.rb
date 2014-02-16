class ApiController < ApplicationController
	def company_search
    company = DunsServer.company_search params[:term]
		render :json => company

	end
end


