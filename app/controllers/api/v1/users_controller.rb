class Api::V1::UsersController < ApplicationController
  respond_to :json
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    render json: User.all
  end
  
  def create
    @user = User.new(sign_up_params.except(:tags))
    if @user.save
      add_tags(@user, sign_up_params[:tag_list])
      tags = @user.user_tags
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @user
  end

  def update
    if @user.update(sign_up_params.except(:email, :tags))
      update_tags(@user, sign_up_params[:tags])
      tags = @user.user_tags
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
    def add_tags user, tags
      if tags.present?
        tags.each do |tag|
          if Tag.find_by(id: tag).present?
            UserTag.create(user_id: user.id, tag_id: tag)
          end
        end
      end
    end

    def update_tags user, tags
      if tags.present?
        current_tags = user.user_tags.pluck(:id)
        if current_tags.present?
          tags_to_delete = current_tags.difference(tags)
          UserTag.where(id: tags_to_delete).destroy_all if tags_to_delete.present?
        else
          tags.each do |tag|
            if Tag.find_by(id: tag).present?
              UserTag.create(user_id: user.id, tag_id: tag)
            end
          end
        end
      else
        user.user_tags.destroy_all if user.user_tags
      end
    end

    def set_user
      @user = User.find(params[:id])
      unless @user
        render json: "User not found", status: 404
      end
    end
    def sign_up_params
      params.require(:user).permit(:name, :email, :mobile_number, :password, :password_confirmation, tags: [])
    end
end