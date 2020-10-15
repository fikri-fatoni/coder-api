class Api::V1::CategoriesController < ApplicationController
  before_action :authenticate_api_user!, except: %i[index show]
  before_action :set_category, only: %i[show update destroy]
  load_and_authorize_resource

  def index
    search = Category.ransack(params[:q])
    search.sorts = 'id asc' if search.sorts.empty?
    result = search.result(distinct: true)
    category = result.page(params[:page]).per(params[:per])

    category_serializer = ActiveModel::Serializer::CollectionSerializer.new(
      category,
      serializer: CategorySerializer
    )

    render json: { count: result.count, data: category_serializer }
  end

  def create
    category = Category.new(category_params)

    if category.save
      render json: {
        success: true,
        messages: 'Berhasil menambahkan data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal menambahkan data',
        error: category.errors.full_messages
      }
    end
  end

  def show
    render json: @category, serializer: CategorySerializer
  end

  def update
    if @category.update(category_params)
      render json: {
        success: true,
        messages: 'Berhasil mengubah data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal mengubah data',
        error: @category.errors.full_messages
      }
    end
  end

  def destroy
    if @category.destroy
      render json: {
        success: true,
        messages: 'Berhasil menghapus data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal menghapus data',
        error: @category.errors.full_messages
      }
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category)
          .permit(
            :name, :description
          )
  end
end
