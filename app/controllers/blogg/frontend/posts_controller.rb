module Blogg
  class Frontend::PostsController < FrontendController
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    layout 'blogg/blog'
    # GET /posts
    # GET /posts.json
    def index
      @posts = Post.all.page params[:page]
      set_meta_tags title: 'Blog'
    end

    # GET /posts/1
    # GET /posts/1.json
    def show
      set_meta_tags title: h(@post.title)
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end
  end
end
