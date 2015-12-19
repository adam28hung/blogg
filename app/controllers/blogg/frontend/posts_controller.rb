module Blogg
  class Frontend::PostsController < FrontendController
    before_action :set_post, only: [:show]
    before_action :set_tagging, :set_category_tree
    before_action :set_search_object, only: [:show, :tag]
    # email, (activejob) sidekiq
    # uploader

    # shortener api server(using heroku & AWS OpsWorks)

    layout 'blogg/blog'
    # GET /posts
    # GET /posts.json
    def index
      @q = Post.ransack(params[:q])
      @posts = @q.result.includes(:categorizations, :categories).page(params[:page])
      # @posts = Post.includes(:categorizations, :categories).page(params[:page])
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

    def search
      index
      render :index
      # @q = Post.ransack(params[:q])
      # @posts = @q.result.includes(:categorizations, :categories).page(params[:page])
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end

      def set_tagging
        # @tags = Post.tag_counts_on(:topics)
        # or top 10
        @tags = Post.tag_counts_on(:topics).order(taggings_count: :desc).limit(10)
      end

      def set_category_tree
        @categories_tree = Category.hash_tree(limit_depth: 1)
      end

      def set_search_object
        @q = Post.ransack(params[:q])
      end

  end
end
