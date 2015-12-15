require 'closure_tree'
module Blogg
  class Category < ActiveRecord::Base
    has_closure_tree dependent: :delete_all, name_column: 'name', order: 'ranking'

    has_many :categorizations, :dependent => :destroy, :foreign_key => :category_id
    has_many :posts, :through => :categorizations , :source => :post
  end
end
