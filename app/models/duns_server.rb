class DunsServer
  include Neo4j::ActiveNode
  def self.company_search(term)
    response = HTTParty.get("http://dnbdirect-api.dnb.com/DnBAPI-13/rest/search/company/#{term}?postBodyContentType=application%2Fjson", :headers => { "Username" => "api3322", "Password" => "welcome", "Api-Key" => "m8z88pw4899qgt8uv7w7779g"})

    cName  = response["resultSet"]["hit"].first["companyResults"]["companyName"]	
    cId  = response["resultSet"]["hit"].first["companyResults"]["companyId"]	

		company = Company.find(uid: cId)
    company ||= Company.create(name:cName,uid:cId)
  end

  def self.competitor_search(company)
		response = HTTParty.get("http://dnbdirect-api.dnb.com/DnBAPI-13/rest/company/#{company.uid}/competitors?top_competitors=false", :headers => { "Username" => "api3322", "Password" => "welcome", "Api-Key" => "m8z88pw4899qgt8uv7w7779g"})
	
	competitorsArray = response["competitor"]

	competitorsArray[0..5].each do |item|
		name = item["companyName"]
		uid = item["companyId"]
		competitor = Company.find(uid: uid)
    competitor ||= Company.create(name: name,uid: uid)
		company.competitors << competitor if competitor
	end	

	return competitorsArray

  end
  def self.news_search(company)
    response = HTTParty.get("http://dnbdirect-api.dnb.com/DnBAPI-13/rest/company/#{company.uid}/news?start_date=2014-01-01&end_date=2014-02-01&filter=GeneralIndustry", :headers => { "Username" => "api3322", "Password" => "welcome", "Api-Key" => "m8z88pw4899qgt8uv7w7779g"})

    newsArray  = response["companyNews"]["newsItems"]["newsItem"]	

    newsArray[0..20].each do |item|
      news = News.new
      news.title = item["title"]
      news.text = item["text"]
      news.source = item["source"]
      news.link = item["link"]
      news.date = item["date"]
      if news.save
        news.companies << company
      end
    end
  end
  def self.marketcap_search(company)
		response = HTTParty.get("http://dnbdirect-api.dnb.com/DnBAPI-13/rest/company/#{company.uid}/market/data", :headers => { "Username" => "api3322", "Password" => "welcome", "Api-Key" => "m8z88pw4899qgt8uv7w7779g"})

	marketcap = response["currentInformation"]["marketCap"]

	company.market_cap = marketcap

  end
end
