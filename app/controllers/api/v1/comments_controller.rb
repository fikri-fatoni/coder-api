class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_api_user!, except: %i[index show]
  before_action :set_comment, only: %i[show update destroy]
  before_action :find_forum, only: %i[index create]
  load_and_authorize_resource

  def index
    search = @forum.comments.ransack(params[:q])
    search.sorts = 'id asc' if search.sorts.empty?
    result = search.result(distinct: true)
    comment = result.page(params[:page]).per(params[:per])

    comment_serializer = ActiveModel::Serializer::CollectionSerializer.new(
      comment,
      serializer: CommentSerializer
    )

    render json: { count: result.count, data: comment_serializer }
  end

  def create
    comment = @forum.comments.new(comment_params)
    comment.user_id = current_user.id
    if comment.save
      render json: {
        success: true,
        messages: 'Berhasil menambahkan data'
      }
    else
      render json: {
        success: false,
        messages: 'Gagal menambahkan data',
        error: comment.errors.full_messages
      }
    end
  end

  def show
    render json: @comment, serializer: CommentSerializer
  end

  def update
    if @comment.user == current_user || current_user.admin?
      if @comment.update(comment_params)
        render json: {
          success: true,
          messages: 'Berhasil mengubah data'
        }
      else
        render json: {
          success: false,
          messages: 'Gagal mengubah data',
          error: @comment.errors.full_messages
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
    if @comment.user == current_user || current_user.admin?
      if @comment.destroy
        render json: {
          success: true,
          messages: 'Berhasil menghapus data'
        }
      else
        render json: {
          success: false,
          messages: 'Gagal menghapus data',
          error: @comment.errors.full_messages
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

  def find_forum
    @forum = Forum.find(params[:forum_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment)
          .permit(
            :body, :forum_id, :user_id
          )
  end
end
