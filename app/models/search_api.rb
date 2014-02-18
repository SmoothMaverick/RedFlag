require 'httparty'

module Gnip
  class Search
    attr_accessor :account, :label, :auth
    include HTTParty
    base_uri "https://search.gnip.com"

    def initialize(options = {})
      options.each do |key, value|
        send(:"#{key}=", value)
      end
      yield self if block_given?
    end

    def options rules, fromDate, toDate, bucket="minute"
      {:body =>
           {:query => rules,
            :bucket => bucket,
            :publisher => "twitter",
            :fromDate => fromDate,
            :toDate => toDate}.to_json,
       :basic_auth => @auth,
       :headers => {'Content-Type' => 'application/json', 'Accept' => 'application/json'}}
    end

    def count rules, fromDate=nil, toDate=nil
      self.class.post("/accounts/#{@account}/search/#{@label}/counts.json", options(rules, fromDate, toDate))
    end

    def activities rules, fromDate=nil, toDate=nil
      self.class.post("/accounts/#{@account}/search/#{@label}.json", options(rules, fromDate, toDate))
    end
  end
end