class Zoho::Api::Plan < Zoho::Request
  ATTRS = [
    :plan_code, :name,
    :recurring_price, :interval,
    :interval_unit, :billing_cycles,
    :trial_period, :setup_fee,
    :product_id, :product_type,
    :hsn_or_sac, :item_tax_preferences,
    :tax_id, :is_taxable,
    :tax_exemption_id, :created_time, :updated_time,
    :tax_exemption_code,:description, :status,
    :error_message, :url
  ]

  ATTRS.each do |attr|
    self.send("attr_accessor", attr)
  end

  def save
    base_url = Zoho::Api::HOST+"/api/v1/plans"
    response = post(base_url) do |http, request|
      request.body = self.to_json
      response = http.request(request)
      response = JSON.parse(response.body, object_class: OpenStruct)
    end
    return response
  end

  class << self
    def all
      base_url = Zoho::Api::HOST+"/api/v1/plans"
      response = get(base_url)
      if response.code == 0
        return response.plans
      else
        return response
      end
    end

    def create(attrs={})
      plan = Zoho::Api::Plan.new(attrs)
      return plan.save
    end

    def find plan_id
      base_url = Zoho::Api::HOST+"/api/v1/plans/#{plan_id}"
      response = get(base_url)
      if response.code == 0
        return response.plan
      else
        return nil
      end
    end

    def update plan_id, attrs={}
      plan = Zoho::Api::Plan.new(attrs)
      base_url = Zoho::Api::HOST+"/api/v1/plans/#{plan_id}"
      response = put(base_url) do |http, request|
        request.body = plan.to_json
        response = http.request(request)
        response = JSON.parse(response.body, object_class: OpenStruct)
      end
      if response.code == 0
        return response
      else
        return response
      end
    end

    def destroy plan_id
      base_url = Zoho::Api::HOST+"/api/v1/plans/#{plan_id}"
      response = Zoho::Request.delete(base_url)
      return response
    end
  end
end
