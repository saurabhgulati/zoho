class Zoho::Api::Product < Zoho::Request
  class << self
    def all
      base_url = Zoho::Api::HOST+"/api/v1/products"
      response = get(base_url)
    end

    def find product_id
      base_url = Zoho::Api::HOST+"/api/v1/products/#{product_id}"
      response = get(base_url)
    end
  end
end
