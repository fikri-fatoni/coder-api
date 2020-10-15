class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :category, :title, :description, :author, :image

  def category
    object.try(:category).name
  end
end
