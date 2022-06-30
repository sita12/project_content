class Api::V1::UsersController < ApiController
  def create
    @user = User.new(user_params)
    if @user.save
      @token = JsonWebToken.encode(user_id: @user.id)
      render 'show'
    else
      render json: {message: @user.errors}, status: :unprocessable_entity
    end
  end    

  private
  def user_params
    params.permit(:first_name, :last_name, :email, :password, :country)
  end
end
