class Api::V1::RolesController < ApplicationController
  before_action :authenticate_api_user!
  before_action :set_role, only: %i[show update destroy]
  load_and_authorize_resource

  def index
    search = Role.ransack(params[:q])
    search.sorts = 'id asc' if search.sorts.empty?
    result = search.result(distinct: true)
    role = result.page(params[:page]).per(params[:per])

    render json: { count: result.count, data: role }
  end

  def create
    role = Role.new(role_params)

    if role.save
      render json: {
        success: true,
        messages: 'Berhasil menambahkan data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal menambahkan data',
        error: role.errors.full_messages
      }
    end
  end

  def show
    render json: @role, serializer: RoleSerializer
  end

  def update
    if @role.update(role_params)
      render json: {
        success: true,
        messages: 'Berhasil mengubah data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal mengubah data',
        error: @role.errors.full_messages
      }
    end
  end

  def destroy
    if @role.destroy
      render json: {
        success: true,
        messages: 'Berhasil menghapus data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal menghapus data',
        error: @role.errors.full_messages
      }
    end
  end

  def assign_role
    user = User.find(params[:user_id])
    if user.add_role(params[:role])
      render json: {
        success: true,
        messages: 'Berhasil menambahkan role'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal menambahkan role',
        error: @role.errors.full_messages
      }
    end
  end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role)
          .permit(
            :name, :resource_type, :resource_id
          )
  end
end
