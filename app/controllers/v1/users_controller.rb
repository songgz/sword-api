class V1::UsersController < ApplicationController
  before_action :set_v1_user, only: %i[ show update destroy ]

  # GET /v1/users
  # GET /v1/users.json
  def index
    @v1_users = V1::User.all
  end

  # GET /v1/users/1
  # GET /v1/users/1.json
  def show
  end

  # POST /v1/users
  # POST /v1/users.json
  def create
    @v1_user = V1::User.new(v1_user_params)

    if @v1_user.save
      render :show, status: :created, location: @v1_user
    else
      render json: @v1_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/users/1
  # PATCH/PUT /v1/users/1.json
  def update
    if @v1_user.update(v1_user_params)
      render :show, status: :ok, location: @v1_user
    else
      render json: @v1_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/users/1
  # DELETE /v1/users/1.json
  def destroy
    @v1_user.destroy
  end

  def recovery_password
    user = User.find(params[:id])
    #user.recovery_password = "123456"
    user.password = '123456'
    user.password_confirmation = "123456"
    user.save

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_user
      @v1_user = V1::User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def v1_user_params
      params.fetch(:user, {}).permit!
    end
end
