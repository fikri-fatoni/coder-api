class Api::V1::VideosController < ApplicationController
  before_action :authenticate_api_user!, except: %i[index]
  before_action :set_video, only: %i[show update destroy]
  load_and_authorize_resource

  def index
    search = Video.ransack(params[:q])
    search.sorts = 'id asc' if search.sorts.empty?
    result = search.result(distinct: true)
    video = result.page(params[:page]).per(params[:per])

    video_serializer = ActiveModel::Serializer::CollectionSerializer.new(
      video,
      serializer: VideoSerializer
    )

    render json: { count: result.count, data: video_serializer }
  end

  def create
    video = Video.new(video_params)
    video.mentor_id = params[:video][:mentor_id].present? ? params[:video][:mentor_id] : current_user.id
    if video.save
      render json: {
        success: true,
        messages: 'Berhasil menambahkan data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal menambahkan data',
        error: video.errors.full_messages
      }
    end
  end

  def show
    if @video.video_type == 'premium'
      if current_user.user_pro? || current_user.admin? || current_user.mentor?
        render json: @video, serializer: VideoSerializer
      else
        render json: {
          success: false,
          messages: 'Tidak memiliki akses'
        }, status: 401
      end
    else
      render json: @video, serializer: VideoSerializer
    end
  end

  def update
    if @video.update(video_params)
      render json: {
        success: true,
        messages: 'Berhasil mengubah data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal mengubah data',
        error: @video.errors.full_messages
      }
    end
  end

  def destroy
    if @video.destroy
      render json: {
        success: true,
        messages: 'Berhasil menghapus data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal menghapus data',
        error: @video.errors.full_messages
      }
    end
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video)
          .permit(
            :title, :description, :thumbnail, :video_link,
            :video_type, :category_id, :mentor_id
          )
  end
end
