require 'gnip/search_api'

class Twitter

  def self.search(query)

    search = Gnip::Search.new do |config|
      config.account = ENV['GNIP_ACCOUNT']
      config.auth = {:username => ENV['GNIP_USERNAME'], :password => ENV['GNIP_PASSWORD']}
      config.label = "prod"
    end

    response = search.activities(query, DateTime.yesterday.strftime("%Y%m%d%H%M"), DateTime.now.strftime("%Y%m%d%H%M")) rescue nil 

    tweets = response["results"]

    return tweets

  end

  def self.company_search(company)
    tweets = Twitter.search(company.name)

    if tweets
      tweet_limit = [tweets.count, 19].min
      tweets[0..tweet_limit].each do |item|
        if tweet = Tweet.find(link: item["link"])
          tweet.companies << company
        else
          tweet = Tweet.new
          tweet.body = item["body"]
          tweet.link = item["link"]
          tweet.date = item["postedTime"]
          tweet.author = item["actor"]["preferredUsername"]
          tweet.uid = item["id"]
          if tweet.save
            tweet.companies << company
          end 
        end 
      end 
    end 

  end

end
