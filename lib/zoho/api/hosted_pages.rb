class Zoho::Api::HostedPage < Zoho::Request
  attr_accessor :customer, :plan, :redirect_url, :subscription_id, :addons

  def save
    base_url = Zoho::Api::HOST+"/api/v1/hostedpages/newsubscription"
    response = post(base_url) do |http, request|
      request.body = self.to_json
      response = http.request(request)
      response = JSON.parse(response.body, object_class: OpenStruct)
    end

    return response
  end

  def find hostpage_id
    return Zoho::Api::HostedPage.find(hostpage_id)
  end

  class << self
    def all
      base_url = Zoho::Api::HOST+"/api/v1/hostedpages"
      response = Zoho::Request.get(base_url)
      if response.code == 0
        return response.hostedpages
      else
        return response
      end
    end

    def find page_id
      base_url = Zoho::Api::HOST+"/api/v1/hostedpages/#{page_id}"
      response = Zoho::Request.get(base_url)
      if response.code == 0
        return response.data
      else
        return response
      end
    end

    def create_subscription attrs={}
      hostpage = Zoho::Api::HostedPage.new(attrs)
      return hostpage.save
    end

    def buy_onetime_addon attrs={}
      hostpage = Zoho::Api::HostedPage.new(attrs)
      base_url = Zoho::Api::HOST+"/api/v1/hostedpages/buyonetimeaddon"
      response = post(base_url) do |http, request|
        request.body = hostpage.to_json
        response = http.request(request)
        response = JSON.parse(response.body, object_class: OpenStruct)
      end
      return response
    end
  end
end
