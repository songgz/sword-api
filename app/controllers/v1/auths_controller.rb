class V1::AuthsController < GuardController
  skip_before_action :authorize_access_request!

  def sign_in
    @user = User.where(acct_no: params[:username]).first
    if @user&.authenticate(params[:password])
      payload = { user_id: @user.id }
      session = JWTSessions::Session.new(payload: payload)
      u = {
        id: @user.id,
        name: @user.name,
        acct_no: @user.acct_no,
        avatar: @user.avatar,
        school_name: @user.school&.name,
        school_id: @user.school_id,
        vip_days: @user.vip_days,
        grade: @user.grade,
        birthday: @user.birthday

      }
      render json: {data: u,tokens: session.login}, status: :accepted
    else
      render json: {error: '用户或密码错误！'}, status: :unauthorized
    end
  end

  def logout
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_access_payload
    render json: :ok
  end

  def change_password
    @user = User.where(id: params[:user_id]).first
    p @user
    if @user
      p params
      @user.password = params[:new_password]
      @user.password_confirmation = params[:confirm_password]
      if @user.save
        render json: :ok, status: :accepted
      else
        render json: {error: '密码错误！'}, status: :unauthorized
      end
    else
      render json: {error: '用户不存在！'}, status: :unauthorized
    end


  end

end
