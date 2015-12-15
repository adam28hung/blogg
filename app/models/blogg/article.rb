module Blogg
  class Article < ActiveRecord::Base
    belongs_to :editable, polymorphic: true
  end
end
