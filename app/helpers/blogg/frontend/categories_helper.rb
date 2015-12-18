module Blogg
  module Frontend::CategoriesHelper

    def render_categories_tree
      tree = Category.hash_tree

      content_tag :div, class: 'col-lg-12' do
        content_tag(:ul, :class => 'list-unstyled') do
          walk_tree(tree)
        end
      end
    end

    def walk_tree(tree, shift=0)
      tree.each do |k,v|
        concat content_tag(:li, create_tree_link_to_category(k, shift))
        if v.present? # node
          shift += 1
          walk_tree(v, shift)
          shift -= 1
        end
      end
    end

    def create_tree_link_to_category(category, shift, options={})
      link_to blogg.category_path(category), style: "padding-left:#{shift*5}px" do
        "#{category.name}".html_safe
      end
    end

    def link_to_parent_path(category, options={})
      if category.parent.present?
        link_to '上一層', backend_category_path(category.parent), options
      else
        link_to '上一層', backend_categories_path, options
      end
    end

    # def render_root_categories
    #   categories = Category.roots
    #   length = categories.count
    #
    #   block1 = content_tag :div, class: 'col-lg-6' do
    #     content_tag(:ul, :class => 'list-unstyled') do
    #       categories[0..(length/2)].each do |category|
    #         path_to_category = link_to category.name, blogg.category_path(category)
    #         concat content_tag(:li, path_to_category)
    #       end
    #     end
    #   end
    #
    #   block2 = content_tag :div, class: 'col-lg-6' do
    #     content_tag(:ul, :class => 'list-unstyled') do
    #       categories[(length/2)+1..length-1].each do |category|
    #         path_to_category = link_to category.name, blogg.category_path(category)
    #         concat content_tag(:li, path_to_category)
    #       end
    #     end
    #   end
    #
    #   block1.concat block2
    #
    # end

  end
end
