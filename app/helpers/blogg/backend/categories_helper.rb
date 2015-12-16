module Blogg
  module Backend::CategoriesHelper
    def render_category_table(categories, options={})
      title = options[:title] || ""

      @categories = Category.where(id: categories.pluck(:id))
      if @categories.count > 0
        render partial: 'table', locals: { section_title: title }
      else
        "沒有子目錄"
      end
    end

    def link_to_parent_path(category, options={})
      if category.parent.present?
        link_to '上一層', backend_category_path(category.parent), options
      else
        link_to '上一層', backend_categories_path, options
      end
    end

  end
end
