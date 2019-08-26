class Zoho::Api::Subscription
  class << self
    def all
      base_url = Zoho::Api::HOST+"/api/v1/subscriptions"
      response = Zoho::Request.get(base_url)
      if response.code == 0
        return response.subscriptions
      else
        return response
      end
    end

    def find subscription_id
      base_url = Zoho::Api::HOST+"/api/v1/subscriptions/#{subscription_id}"
      response = Zoho::Request.get(base_url)
      if response.code == 0
        return response.subscription
      else
        return response
      end
    end

    def cancel subscription_id
      base_url = Zoho::Api::HOST+"/api/v1/subscriptions/#{subscription_id}/cancel"
      response = Zoho::Request.post(base_url) do |http, request|
        response = http.request(request)
        response = JSON.parse(response.body, object_class: OpenStruct)
      end
      return response
    end
  end
end
