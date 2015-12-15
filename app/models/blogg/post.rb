module Blogg
  class Post < ActiveRecord::Base

    has_one :article, as: :editable , dependent: :destroy
    has_many :categorizations, :dependent => :destroy, :foreign_key => :post_id
    has_many :categories, :through => :categorizations, :source => :category

    acts_as_taggable_on :topics

    accepts_nested_attributes_for :article

  end
end
