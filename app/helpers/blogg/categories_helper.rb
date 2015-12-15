module Blogg
  module CategoriesHelper
    def render_category_table(categories, options={})
      title = options[:title] || ""

      @categories = Category.where(id: categories.pluck(:id))
      render partial: 'table', locals: { section_title: title } if @categories.count > 0
    end
  end
end
