module Blogg
  class Backend::CategoriesController < BackendController
    before_action :set_category, only: [:show, :edit, :update, :destroy]
    # before_action :set_function_title

    def index
      @categories = Category.roots
    end

    def new
      @category = Category.new
      # @category.cover = CategoryCover.new
    end

    def create
      @category = Category.create!(category_params)

      if @category.save
        flash[:notice] = "更新成功"
        redirect_to backend_category_path(@category)
      else
        render :new , notice: @category.errors.full_messages
      end

    end

    def show
      @categories = @category.children
      @sub_category = @category.children.new
      # @sub_category.cover = CategoryCover.new
    end

    def edit
      # unless @category.cover.present?
        # @category.build_cover #= CategoryCover.new
      # end
    end

    def update
      if @category.update(category_params)
        flash[:notice] = "修改成功"
        redirect_to backend_category_path(@category)
      else
        render :edit
      end
    end

    def destroy
      @category.destroy
      flash[:notice] = "刪除成功"
      redirect_to backend_categories_path
    end

    # def destroy_cover_of
    #   @gallery = Gallery.find(@category.cover.id)
    #   @gallery.destroy
    #   # public/uploads/attachment/#{model.attachable_type}/#{model.attachable_id}/attachment/#{model.id}
    #   #-- delete file only (remain lots of empty folder)
    #   #@attachmentpath = "public/uploads/attachment/" + @attachment.attachable_type.to_s + "/" + @attachment.attachable_id.to_s + "/attachment/" + @attachment.id.to_s + "/" + @attachment.file_name
    #   #File.delete(@attachmentpath)
    #   #-- delete file only end
    #
    #   # =================== temp
    #   #delete entire folder
    #   # @attachmentpath = "public/uploads/gallery/" + @gallery.attachable_type.to_s + "/" + @gallery.attachable_id.to_s + "/attachment/" + @gallery.id.to_s
    #   # FileUtils.rm_rf(@attachmentpath)
    #
    #   respond_to do |format|
    #     flash[:notice] = "封面刪除成功"
    #     format.html { redirect_to administration_category_path(@category, locale: @category.locale) }
    #   end
    # end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      # "category"=>{
      #   "name"=>"uptest in new",
      #   "locale"=>"zh_tw",
      #   "cover_attributes"=>{"attachment"=>#<ActionDispatch::Http::UploadedFile:0x007fc996d9caf8 @tempfile=#<Tempfile:/var/folders/mp/4z4k7p190kbcr4t4kws568bm0000gn/T/RackMultipart20151126-63936-uni8fq.png>, @original_filename="runpic.png", @content_type="image/png", @headers="Content-Disposition: form-data; name=\"category[cover_attributes][attachment]\"; filename=\"runpic.png\"\r\nContent-Type: image/png\r\n">}
      # }
      params.require(:category).permit( :name, :locale, {:cover_attributes => :attachment }, :ranking, :parent_id )
    end

  end
end
