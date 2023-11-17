class V1::AuthsController < GuardController
  skip_before_action :authorize_access_request!

  def sign_in
    @user = User.find_by!(acct_no: params[:username])
    if @user.authenticate(params[:password])
      payload = { user_id: @user.id }
      session = JWTSessions::Session.new(payload: payload)
      u = {name: @user.name, acct_no: @user.acct_no, avatar: @user.avatar, school_name: @user.school_id}
      render json: {data: u,tokens: session.login}, status: :accepted
    else
      render json: {error: 'Incorrect password'}, status: :unauthorized
    end
  end

  def logout
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_access_payload
    render json: :ok
  end

end
