class ApiController < ApplicationController
	def company_search
    company = DunsServer.company_search params[:term]
		news = DunsServer.news_search(company)
		competitor = DunsServer.competitor_search(company)
		render :json => company
	end
end


