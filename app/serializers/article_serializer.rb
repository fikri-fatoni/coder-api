class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :author, :image, :category

  def category
    object.try(:category).name
  end
end
