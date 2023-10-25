class V1::MenuItemsController < ApplicationController
  before_action :set_v1_menu_item, only: %i[ show update destroy ]

  # GET /v1/menu_items
  # GET /v1/menu_items.json
  def index
    @v1_menu_items = MenuItem.includes(:parent).all.to_a
    #@pagination = pagination(@v1_menu_items)
  end

  # GET /v1/menu_items/1
  # GET /v1/menu_items/1.json
  def show
  end

  # POST /v1/menu_items
  # POST /v1/menu_items.json
  def create
    @v1_menu_item = MenuItem.new(v1_menu_item_params)

    if @v1_menu_item.save
      render :show, status: :created, location: @v1_menu_item
    else
      render json: @v1_menu_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/menu_items/1
  # PATCH/PUT /v1/menu_items/1.json
  def update
    if @v1_menu_item.update(v1_menu_item_params)
      render :show, status: :ok, location: @v1_menu_item
    else
      render json: @v1_menu_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/menu_items/1
  # DELETE /v1/menu_items/1.json
  def destroy
    @v1_menu_item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_menu_item
      @v1_menu_item = MenuItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def v1_menu_item_params
      params.fetch(:v1_menu_item, {})
    end
end
