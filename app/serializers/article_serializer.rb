class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image, :category, :author

  def image
    image = object.try(:image)
    { thumb: { url: image.try(:url) } }
  end

  def category
    category = object.try(:category)
    {
      id: category.try(:id),
      name: category.try(:name)
    }
  end

  def author
    author = object.try(:author)
    {
      id: author.try(:id),
      first_name: author.try(:first_name),
      last_name: author.try(:last_name),
      avatar: { url: author.try(:avatar).url }
    }
  end
end
