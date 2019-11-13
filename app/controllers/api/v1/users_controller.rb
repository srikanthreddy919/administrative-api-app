class Api::V1::UsersController < ApplicationController
  respond_to :json
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :ensure_tags_exist, only: [:create, :update]

  def index
    sort_by = params[:sort_by] || "name"
    sort_order = params[:sort_order] || "asc"
    search = params[:search]
    @users = User.order("#{sort_by} #{sort_order}")
    @users = @users.where("email ILIKE ? OR name ILIKE ?", "%#{search}%", "%#{search}%") if search.present?

    render json: @users
  end
  
  def create
    @user = User.new(user_params.except(:tags))
    if @user.save
      add_tags(@user, user_params[:tags])
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @user
  end

  def update
    if @user.update(user_params.except(:email, :tags))
      update_tags(@user, user_params[:tags])
      render json: @user, status: :accepted
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

    def ensure_tags_exist 
      tags = user_params[:tags] || []
      render json: "One or more tags doesn't exist", status: :unprocessable_entity if tags.count != Tag.where(id: tags).count
      return
    end

    def add_tags user, tags
      if tags.present?
        tags.each do |tag|
          user.user_tags.find_or_create_by(tag_id: tag)
        end
      end
    end

    def update_tags user, tags=[]
      user.user_tags.where.not(tag_id: tags).destroy_all
      tags.each do |tag|
        user.user_tags.find_or_create_by(tag_id: tag)
      end
    end

    def set_user
      @user = User.find(params[:id])
      unless @user
        render json: "User not found", status: 404
      end
    end

    def user_params
      params.require(:user).permit(:name, :email, :mobile_number, :password, :password_confirmation, :disabled, tags: [])
    end
end