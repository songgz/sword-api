# frozen_string_literal: true

module ResponseHelper
  def response_json
    JSON.parse(response.body) rescue {}
  end
end

RSpec.configure do |config|
  config.include ResponseHelper
end
