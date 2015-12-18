module Blogg
  class Frontend::PostsController < FrontendController
    before_action :set_post, only: [:show]
    before_action :set_tagging

    layout 'blogg/blog'
    # GET /posts
    # GET /posts.json
    def index
      @posts = Post.includes(:categorizations, :categories).page(params[:page])
      set_meta_tags title: 'Blog'
    end

    # GET /posts/1
    # GET /posts/1.json
    def show
      set_meta_tags title: h(@post.title)
    end

    def tag
      if Post.topic_counts.pluck(:name).include?(params[:tag])
        @posts = Post.includes(:categorizations, :categories).tagged_with(params[:tag]).page(params[:page])
      else
        redirect_to blogg.posts_path
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end

      def set_tagging
        # @tags = Post.tag_counts_on(:topics)
        # or top 10
        @tags = Post.tag_counts_on(:topics).sort.take(10)
      end

  end
end
