module Blogg
  class Article < ActiveRecord::Base
    belongs_to :editable, polymorphic: true

    after_save do
      editable.touch
    end

  end
end
