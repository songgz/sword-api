class V1::AuthsController < GuardController
  skip_before_action :authorize_access_request!
  before_action :set_v1_auth, only: %i[ show update destroy ]

  # GET /v1/auths
  def index
    @v1_auths = V1::Auth.all

    render json: @v1_auths
  end

  # GET /v1/auths/1
  def show
    render json: @v1_auth
  end

  # POST /v1/auths
  def create
    @v1_auth = V1::Auth.new(v1_auth_params)

    if @v1_auth.save
      render json: @v1_auth, status: :created, location: @v1_auth
    else
      render json: @v1_auth.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/auths/1
  def update
    if @v1_auth.update(v1_auth_params)
      render json: @v1_auth
    else
      render json: @v1_auth.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/auths/1
  def destroy
    @v1_auth.destroy
  end

  def sign_in
    @user = User.find_by!(userid: params[:userid])
    if @user.authenticate(params[:password])
      payload = { user_id: @user.id }
      session = JWTSessions::Session.new(payload: payload)
      render json: session.login, status: :accepted
    else
      render json: {error: 'Incorrect password'}, status: :unauthorized
    end
  end

  def logout
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_access_payload
    render json: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_auth
      @v1_auth = V1::Auth.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def v1_auth_params
      params.fetch(:v1_auth, {})
    end
end
