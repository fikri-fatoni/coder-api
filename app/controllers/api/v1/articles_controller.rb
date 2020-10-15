class Api::V1::ArticlesController < ApplicationController
  before_action :authenticate_api_user!, except: %i[index show]
  before_action :set_article, only: %i[show update destroy]
  load_and_authorize_resource

  def index
    search = Article.ransack(params[:q])
    search.sorts = 'id asc' if search.sorts.empty?
    result = search.result(distinct: true)
    article = result.page(params[:page]).per(params[:per])

    article_serializer = ActiveModel::Serializer::CollectionSerializer.new(
      article,
      serializer: ArticleSerializer
    )

    render json: { count: result.count, data: article_serializer }
  end

  def create
    article = Article.new(article_params)
    article.author_id = current_user.id
    if article.save
      render json: {
        success: true,
        messages: 'Berhasil menambahkan data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal menambahkan data',
        error: article.errors.full_messages
      }
    end
  end

  def show
    render json: @article, serializer: ArticleSerializer
  end

  def update
    if @article.update(article_params)
      render json: {
        success: true,
        messages: 'Berhasil mengubah data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal mengubah data',
        error: @article.errors.full_messages
      }
    end
  end

  def destroy
    if @article.destroy
      render json: {
        success: true,
        messages: 'Berhasil menghapus data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal menghapus data',
        error: @article.errors.full_messages
      }
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article)
          .permit(
            :title, :description, :image, :category_id, :author_id
          )
  end
end
