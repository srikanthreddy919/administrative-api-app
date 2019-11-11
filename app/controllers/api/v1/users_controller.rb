class Api::V1::UsersController < Devise::RegistrationsController
  respond_to :json
  before_action :authenticate_user!
  
  def create
    build_resource(sign_up_params)

    resource.save
    render_resource(resource)
  end

  private
    def sign_up_params
      params.require(:user).permit(:name, :email, :mobile_number, :password, :password_confirmation)
    end
end