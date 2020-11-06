class Api::V1::Overrides::SessionsController < DeviseTokenAuth::SessionsController
  def new
    super
  end

  def create
    super do
      render json: {
        id: current_user.id,
        username: current_user.username,
        first_name: current_user.first_name,
        'access-token': @token.token,
        'token-type': 'Bearer',
        client: @token.client,
        uid: current_user.email
      }.to_json and return
    end
  end
end
