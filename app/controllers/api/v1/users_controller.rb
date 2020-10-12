class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    search = User.ransack(params[:q])
    search.sorts = 'id asc' if search.sorts.empty?
    result = search.result(distinct: true)
    @users = result.page(params[:page]).per(params[:per])

    user_serializer = ActiveModel::Serializer::CollectionSerializer.new(
      @users,
      serializer: User::IndexSerializer
    )

    render json: { count: result.count, data: user_serializer }
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: {
        success: true,
        messages: 'Berhasil menambahkan data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal menambahkan data',
        error: user.errors.full_messages
      }
    end
  end

  def show
    render json: @user, serializer: User::UserSerializer
  end

  def update
    if @user.update(user_params)
      render json: {
        success: true,
        messages: 'Berhasil mengubah data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal mengubah data',
        error: @user.errors.full_messages
      }
    end
  end

  def destroy
    if @user.destroy
      render json: {
        success: true,
        messages: 'Berhasil menghapus data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal menghapus data',
        error: @user.errors.full_messages
      }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user)
          .permit(
            :username, :password, :email, :first_name, :last_name,
            :phone_number, :date_of_birth, :programming_skill
          )
  end
end
