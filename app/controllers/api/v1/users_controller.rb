class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_user!
  load_and_authorize_resource

  def index
    search = User.ransack(params[:q])
    search.sorts = 'id asc' if search.sorts.empty?
    result = search.result
    user = result.page(params[:page]).per(params[:per])

    user_serializer = ActiveModel::Serializer::CollectionSerializer.new(
      user,
      serializer: UserSerializer
    )

    render json: { count: result.count, data: user_serializer }
  end
end
