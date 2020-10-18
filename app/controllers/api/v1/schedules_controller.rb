class Api::V1::SchedulesController < ApplicationController
  before_action :authenticate_api_user!, except: %i[index show]
  before_action :set_schedule, only: %i[show update destroy]
  load_and_authorize_resource

  def index
    search = Schedule.ransack(params[:q])
    search.sorts = 'id asc' if search.sorts.empty?
    result = search.result(distinct: true)
    schedule = result.page(params[:page]).per(params[:per])

    schedule_serializer = ActiveModel::Serializer::CollectionSerializer.new(
      schedule,
      serializer: ScheduleSerializer
    )

    render json: { count: result.count, data: schedule_serializer }
  end

  def create
    schedule = Schedule.new(schedule_params)
    schedule.mentor_id = params[:schedule][:mentor_id].present? ? params[:schedule][:mentor_id] : current_user.id
    if schedule.save
      render json: {
        success: true,
        messages: 'Berhasil menambahkan data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal menambahkan data',
        error: schedule.errors.full_messages
      }
    end
  end

  def show
    render json: @schedule, serializer: ScheduleSerializer
  end

  def update
    if @schedule.update(schedule_params)
      render json: {
        success: true,
        messages: 'Berhasil mengubah data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal mengubah data',
        error: @schedule.errors.full_messages
      }
    end
  end

  def destroy
    if @schedule.destroy
      render json: {
        success: true,
        messages: 'Berhasil menghapus data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal menghapus data',
        error: @schedule.errors.full_messages
      }
    end
  end

  private

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def schedule_params
    params.require(:schedule)
          .permit(
            :title, :description, :google_form_link, :schedule_type, :status,
            :learning_tool, :event_date, :category_id, :mentor_id
          )
  end
end
