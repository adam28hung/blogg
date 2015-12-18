module Blogg
  module Frontend::PostsHelper
    include Frontend::ArticlesHelper

    def render_post_header(post, options={})
      if post.present?
        h1_title = options[:main_title] || post.title
        h2_title = options[:sub_title] || truncate(post.description, length: 50, omission: "...")
        foot = options[:meta] || "Posted on #{post.created_at.strftime(%Q(%d %b, %Y))}"
        render partial: 'blogg/frontend/posts/post_header', locals: { h1_title: h1_title, h2_title: h2_title, foot: foot}
      else
        "invalid"
      end
    end


  end
end
