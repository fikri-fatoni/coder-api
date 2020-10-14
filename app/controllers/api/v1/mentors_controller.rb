class Api::V1::MentorsController < ApplicationController
  before_action :authenticate_api_user!, except: %i[index show]
  before_action :set_mentor, only: %i[show update destroy]

  def index
    search = Mentor.ransack(params[:q])
    search.sorts = 'id asc' if search.sorts.empty?
    result = search.result(distinct: true)
    mentor = result.page(params[:page]).per(params[:per])

    mentor_serializer = ActiveModel::Serializer::CollectionSerializer.new(
      mentor,
      serializer: MentorSerializer
    )

    render json: { count: result.count, data: mentor_serializer }
  end

  def create
    mentor = Mentor.new(mentor_params)

    if mentor.save
      render json: {
        success: true,
        messages: 'Berhasil menambahkan data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal menambahkan data',
        error: mentor.errors.full_messages
      }
    end
  end

  def show
    render json: @mentor, serializer: MentorSerializer
  end

  def update
    if @mentor.update(mentor_params)
      render json: {
        success: true,
        messages: 'Berhasil mengubah data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal mengubah data',
        error: @mentor.errors.full_messages
      }
    end
  end

  def destroy
    if @mentor.destroy
      render json: {
        success: true,
        messages: 'Berhasil menghapus data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal menghapus data',
        error: @mentor.errors.full_messages
      }
    end
  end

  private

  def set_mentor
    @mentor = Mentor.find(params[:id])
  end

  def mentor_params
    params.require(:mentor)
          .permit(
            :first_name, :last_name, :description, :expertise, :email
          )
  end
end
