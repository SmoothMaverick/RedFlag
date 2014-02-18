require 'gnip/search_api'

class Twitter

  def search(query)
    search = Gnip::Search.new do |config|
      config.account = ENV['GNIP_ACCOUNT']
      config.auth = {:username => ENV['GNIP_USERNAME'], :password => ENV['GNIP_PASSWORD']}
      config.label = "prod"
    end

    search.activities(query, DateTime.yesterday.strftime("%Y%m%d%H%M"), DateTime.now.strftime("%Y%m%d%H%M"))
  end

end

