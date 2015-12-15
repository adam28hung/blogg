module Blogg
  module CategoriesHelper
    def render_category_table(categories, options={})
      title = options[:title] || ""

      @categories = Category.where(id: categories.pluck(:id))
      render partial: 'table', locals: { section_title: title } if @categories.count > 0
    end

    def link_to_parent_path(category, options={})
      if category.parent.present?
        link_to '上一層', category_path(category.parent), options
      else
        link_to '上一層', categories_path, options
      end
    end

  end
end
