class Zoho::Request
  def initialize attrs={}
    attrs.each do |key, val|
      self.send("#{key}=", val)
    end
  end

  def attributes
    hsh = {}
    self.class.const_get("ATTRS").each do |attr|
      hsh[attr] = self.send(attr)
    end
    return hsh
  end

  def get url, &blk
    Zoho::Request.get url, &blk
  end

  def post url, &blk
    Zoho::Request.post url, &blk
  end

  def put url, &blk
    Zoho::Request.put url, &blk
  end

  def delete url, &blk
    Zoho::Request.delete url, &blk
  end

  def self.get url, &blk
    url = URI(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url)
    add_request_headers request
    response = http.request(request)
    if block_given?
      yield(response)
    else
      return JSON.parse(
        response.read_body,
        object_class: OpenStruct
      )
    end
  end

  def self.post url, &blk
    url = URI(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(url)
    add_request_headers request
    yield(http, request)
  end

  def self.put url, &blk
    url = URI(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Put.new(url)
    add_request_headers request
    yield(http, request)
  end

  def self.delete url
    url = URI(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Delete.new(url)
    add_request_headers request
    response = http.request(request)
    return JSON.parse(
      response.read_body,
      object_class: OpenStruct
    )
  end

  private

  def self.add_request_headers request
    raise "Zoho not configured!" unless Zoho.configuration.present?
    request["Authorization"] = Zoho.configuration.auth_token
    request["X-com-zoho-subscriptions-organizationid"] = Zoho.configuration.organization_id
    request["content-type"] = 'application/json;charset=UTF-8'
  end
end
