class CompaniesController < ApplicationController
  def search

  end

  def company_search
    @company = DunsServer.company_search params[:term]
    news = DunsServer.news_search(@company)
    competitor = DunsServer.competitor_search(@company)
    marketcap = DunsServer.marketcap_search(@company)
  end

  def company_json
    @company = Company.find(uid: params[:uid].to_i)
    render json: @company.graph_json
  end

end
