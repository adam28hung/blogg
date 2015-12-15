module Blogg
  module ArticlesHelper

    def collection_for_select2(args)
      article = args[:article]
      tag_context = "#{args[:tag_context]}_list".to_sym
      article.send tag_context
    end

  end
end
