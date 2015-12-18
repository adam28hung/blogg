module Blogg
  module Frontend::ArticlesHelper
    include ActsAsTaggableOn::TagsHelper

    def render_tag_list(args={})
      article = args[:article]
      tag_context = "#{args[:tag_context]}_list".to_sym # which tag_list: "#{topic}_list"
      tag_list = article.send tag_context
      if tag_list.present?
        "#{tag_list}"
      else
        ""
      end
    end

    def render_tag_links(args={})
      article = args[:article]
      tag_context = "#{args[:tag_context]}s".to_sym # which tag_list: "#{topic}_list"
      tag_list = article.send tag_context

      tag_links = '<i class="fa fa-tags"></i>'
      tag_links = '' if tag_list.count == 0

      tag_list.each do |tag|
        tag_label = content_tag(:span, "#{tag.name}")
        link_to_tag = link_to blogg.tag_posts_path(tag.name), class: 'btn-sm btn-default' do
          tag_label
        end
        tag_links << link_to_tag
      end

      return tag_links.html_safe
    end

  end
end
