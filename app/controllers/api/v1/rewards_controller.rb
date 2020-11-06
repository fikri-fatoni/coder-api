class Api::V1::RewardsController < ApplicationController
  before_action :authenticate_api_user!, except: %i[index show]
  before_action :set_reward, only: %i[show update destroy]
  load_and_authorize_resource

  def index
    search = Reward.ransack(params[:q])
    search.sorts = 'id asc' if search.sorts.empty?
    result = search.result(distinct: true)
    reward = result.page(params[:page]).per(params[:per])

    reward_serializer = ActiveModel::Serializer::CollectionSerializer.new(
      reward,
      serializer: RewardSerializer
    )

    render json: { count: result.count, data: reward_serializer }
  end

  def create
    reward = Reward.new(reward_params)

    if reward.save
      render json: {
        success: true,
        messages: 'Berhasil menambahkan data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal menambahkan data',
        error: reward.errors.full_messages
      }
    end
  end

  def show
    render json: @reward, serializer: RewardSerializer
  end

  def update
    if @reward.update(reward_params)
      render json: {
        success: true,
        messages: 'Berhasil mengubah data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal mengubah data',
        error: @reward.errors.full_messages
      }
    end
  end

  def destroy
    if @reward.destroy
      render json: {
        success: true,
        messages: 'Berhasil menghapus data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal menghapus data',
        error: @reward.errors.full_messages
      }
    end
  end

  private

  def set_reward
    @reward = Reward.find(params[:id])
  end

  def reward_params
    params.require(:reward)
          .permit(
            :name, :description
          )
  end
end
