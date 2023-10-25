class V1::AuthController < GuardController
  skip_before_action :authorize_access_request!


  def sign_in
    user = User.find_by!(userid: params[:userid])
    if user.authenticate(params[:password])
      payload = { user_id: user.id }
      session = JWTSessions::Session.new(payload: payload)
      render json: {user: user, token: session.login}, status: :accepted
    else
      render json: {error: 'Incorrect password'}, status: :unauthorized
    end
  end
end
