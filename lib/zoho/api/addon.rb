class Zoho::Api::Addon < Zoho::Request
  ATTRS = [
    :addon_code,
    :name,
    :unit_name,
    :pricing_scheme,
    :price_brackets,
    :type,
    :applicable_to_all_plans,
    :product_id,
    :description
  ]

  ATTRS.each do |attr|
    self.send("attr_accessor", attr)
  end

  def save
    base_url = Zoho::Api::HOST+"/api/v1/addons"
    response = post(base_url) do |http, request|
      request.body = self.to_json
      response = http.request(request)
      response = JSON.parse(response.body, object_class: OpenStruct)
    end
    return response
  end

  class << self
    def all
      base_url = Zoho::Api::HOST+"/api/v1/addons"
      response = get(base_url)
      if response.code == 0
        return response.addons
      else
        return response
      end
    end

    def create(attrs={})
      addon = Zoho::Api::Addon.new(attrs)
      return addon.save
    end

    def find addon_id
      base_url = Zoho::Api::HOST+"/api/v1/addons/#{addon_id}"
      response = get(base_url)
      if response.code == 0
        return response.addon
      else
        return nil
      end
    end

    def update addon_id, attrs={}
      addon = Zoho::Api::Addon.new(attrs)
      base_url = Zoho::Api::HOST+"/api/v1/addons/#{addon_id}"
      response = put(base_url) do |http, request|
        request.body = addon.to_json
        response = http.request(request)
        response = JSON.parse(response.body, object_class: OpenStruct)
      end
      if response.code == 0
        return response
      else
        return response
      end
    end

    def destroy addon_id
      base_url = Zoho::Api::HOST+"/api/v1/addons/#{addon_id}"
      response = Zoho::Request.delete(base_url)
      return response
    end
  end
end
