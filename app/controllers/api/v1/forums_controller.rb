class Api::V1::ForumsController < ApplicationController
  before_action :authenticate_api_user!, except: %i[index show]
  before_action :set_forum, only: %i[show update destroy]
  load_and_authorize_resource

  def index
    search = Forum.ransack(params[:q])
    search.sorts = 'id asc' if search.sorts.empty?
    result = search.result(distinct: true)
    forum = result.page(params[:page]).per(params[:per])

    forum_serializer = ActiveModel::Serializer::CollectionSerializer.new(
      forum,
      serializer: Forum::IndexSerializer
    )

    render json: { count: result.count, data: forum_serializer }
  end

  def create
    forum = Forum.new(forum_params)
    forum.user_id = current_user.id
    if forum.save
      render json: {
        success: true,
        messages: 'Berhasil menambahkan data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal menambahkan data',
        error: forum.errors.full_messages
      }
    end
  end

  def show
    render json: @forum, serializer: Forum::ShowSerializer
  end

  def update
    if @forum.user == current_user || current_user.admin?
      if @forum.update(forum_params)
        render json: {
          success: true,
          messages: 'Berhasil mengubah data'
        }
      else
        render json: {
          success: false,
          messages: 'Gagal mengubah data',
          error: @forum.errors.full_messages
        }
      end
    else
      render json: {
        success: false,
        messages: 'Tidak memiliki akses'
      }, status: 401
    end
  end

  def destroy
    if @forum.user == current_user || current_user.admin?
      if @forum.destroy
        render json: {
          success: true,
          messages: 'Berhasil menghapus data'
        }
      else
        render json: {
          success: false,
          messages: 'Gagal menghapus data',
          error: @forum.errors.full_messages
        }
      end
    else
      render json: {
        success: false,
        messages: 'Tidak memiliki akses'
      }, status: 401
    end
  end

  private

  def set_forum
    @forum = Forum.find(params[:id])
  end

  def forum_params
    params.require(:forum)
          .permit(
            :title, :body, :image, :like, :category_id, :user_id
          )
  end
end
