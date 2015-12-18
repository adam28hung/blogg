module Blogg
  class Frontend::CategoriesController < FrontendController
    before_action :set_category, only: [:show]
    layout 'blogg/blog'

    # here to start
    def index
      #work
      # @categories = Category.includes(:posts).roots.uniq
      @categories = Category.includes(:categorizations,:posts).roots
      # .group('blogg_categories_id').having('count(blogg_posts_id) > 1')
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

  end
end
