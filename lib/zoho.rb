require "zoho/railtie"
require "zoho/engine"
module Zoho
  class << self
    attr_accessor :configuration

    def configure &blk
      self.configuration ||= Zoho::Configuration.new.tap(&blk)
    end
  end

  class Configuration
    attr_accessor :organization_id, :auth_token
    TOKEN_PREFIX = "Zoho-authtoken"

    def initialize(options={})
      options.each do |key, value|
        if key.to_s == "auth_token"
          self[key] = "#{TOKEN_PREFIX} #{value}"
        else
          self[key] = value
        end
      end
    end
  end

  module Api
    # attr_accessor :configuration
    HOST = "https://subscriptions.zoho.com"
  end
  require "zoho/request"
  require "zoho/api/hosted_pages"
  require "zoho/api/plan"
  require "zoho/api/product"
  require "zoho/api/addon"
  require "zoho/api/subscription"
end
