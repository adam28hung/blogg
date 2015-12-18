module Blogg
  class Post < ActiveRecord::Base
    paginates_per 5

    has_one :article, as: :editable , dependent: :destroy
    has_many :categorizations, :dependent => :destroy, :foreign_key => :post_id
    has_many :categories, :through => :categorizations, :source => :category

    acts_as_taggable_on :topics

    accepts_nested_attributes_for :article

    scope :latest, -> { order(created_at: :desc)}

    def previous(options={})
      condition = set_pager_default(options)
      previous_posts(condition)
    end

    def next(options={})
      condition = set_pager_default(options)
      next_posts(condition)
    end

    def within(options={})
      condition = set_pager_default(options)
      posts_within(condition)
    end

    private

    def previous_posts(options={})
      Post.where("#{options[:order_by_column]} < ?", self.send(options[:column])).last(options[:shift]) #|| Post.first
    end

    def next_posts(options={})
      Post.where("#{options[:order_by_column]} > ?", self.send(options[:column])).first(options[:shift]) #|| Post.last
    end

    def posts_within(options={})
      collection = Post.send(options[:scope].to_sym).pluck(options[:column])

      base = collection.index(options[:start_from].send(options[:column]))
      begin_from = (base-options[:shift] < 0)? 0 : base-options[:shift]
      end_at = (base+options[:shift] > collection.length-1)? collection.length : base+options[:shift]

      unless options[:with_self]
        collection.delete(options[:start_from].send(options[:column]))
        end_at -= 1 unless (Post.columns_hash[options[:order_by_column]].type == :datetime)
      end
      Post.send(options[:scope].to_sym).where(options[:column] => collection[(begin_from..end_at)])
    end

    def set_pager_default(options={})
      args={}
      args[:start_from] = options[:start_from] || self
      args[:shift] = options[:shift] || 1
      args[:order_by_column] = options[:order_by] || 'id'
      args[:column] = args[:order_by_column].to_sym
      args[:scope] = options[:scope] || 'all'
      args[:with_self] = options[:with_self] || false
      return args
    end

    # def posts_between(options={})
    #   condition = pager_default(options)
    #   collection = []
    #   collection << previous_posts(condition)
    #   collection << self if condition[:with_self]
    #   collection << next_posts(condition)
    # end

  end
end
