class Api::V1::TagsController < ApplicationController 
  before_action :set_tag, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  # GET /tags
  def index
    sort_order = params[:sort_order] || "asc"
    search = params[:search]
    @tags = Tag.order("name #{sort_order}")
    @tags = @tags.where("name ILIKE ?", "%#{search}%") if search.present?

    render json: @tags
  end

  # GET /tags/1
  def show
    render json: @tag
  end

  # POST /tags
  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      render json: @tag, status: :created
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tags/1
  def update
    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1
  def destroy
    @tag.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tag_params
      params.fetch(:tag, {}).permit(:name)
    end
  
end