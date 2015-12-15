module Blogg
  module PostsHelper

    def render_my_category(args={})
      article = args[:article]
      category = article.categories.first
      # maybe link_to or other functionalities
      if category.present?
        args[:plain]? "#{category.name}" : "所屬分類： #{category.name}"
      end

    end

    # [display]
    def render_tag_list(args)
      article = args[:article]
      tag_context = "#{args[:tag_context]}_list".to_sym # which tag_list: "#{topic}_list"
      tag_list = article.send tag_context
      if tag_list.present?
        content_tag(:p, "Tags: #{tag_list}<hr>".html_safe )
      else
        content_tag(:p, "Tags: nil <hr>".html_safe, style: 'color:grey;' )
      end
    end

    def nested_hierarchy_for_select(items)
      result = []
      items.map do |item, sub_items|
        result << [('- ' * item.depth) + item.name, item.id]
        result += nested_hierarchy_for_select(sub_items) unless sub_items.blank?
      end
      result
    end

  end
end
