module Blogg
  class Frontend::CategoriesController < FrontendController
    before_action :set_category, only: [:show]
    before_action :set_tagging ,:set_category_tree #, only: [:index]
    before_action :set_search_object

    layout 'blogg/blog'

    def index
      @categories = Category.includes(:categorizations,:posts).roots
    end

    def show
      @posts = @category.posts.page params[:page]

      set_meta_tags title: h("#{@category.name} 文章列表")
    end


    private

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    def set_tagging
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
