class CompaniesController < ApplicationController
  def index
  end

  def graph
    crawl = true
    if crawl
      limit = params[:limit] || 10
      @company = DunsServer.company_crawl(params[:term], limit: limit)
    else
      @company = DunsServer.company_search params[:term]
      news = DunsServer.news_search(@company)
      competitor = DunsServer.competitor_search(@company)
      # marketcap = DunsServer.marketcap_search(@company)
      tweets = Twitter.company_search(@company)
    end
  end

  def company_json
    @company = Company.find(uid: params[:uid].to_i)
    render json: @company.graph_json
  end
end
