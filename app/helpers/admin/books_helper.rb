module Admin::BooksHelper
  def categories
    categories = Category.all.map {|c| [c.name, c.id]}
  end
end
