# frozen_string_literal: true

module AuthHelper
  def authenticated_header(user)
    payload = { userid: user.userid }
    session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
    access_token, csrf_token = session.login.values_at(:access, :csrf)
    cookies[JWTSessions.access_cookie] = access_token

    return {
      "#{JWTSessions.csrf_header}": csrf_token,
      'Accept' => 'application/json'
    }
  end
end

RSpec.configure do |config|
  config.include AuthHelper
end
