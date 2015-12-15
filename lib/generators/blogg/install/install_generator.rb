require 'rails/generators/migration'

module Blogg
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      desc "add the Blogg migrations"

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migrations
        migration_template_path = File.expand_path('../templates', __FILE__)

        migration_template File.join(migration_template_path,"create_blogg_articles.rb"), "db/migrate/create_blogg_articles.rb"
        migration_template File.join(migration_template_path,"create_blogg_categories.rb"), "db/migrate/create_blogg_categories.rb"
        migration_template File.join(migration_template_path,"create_blogg_categorizations.rb"), "db/migrate/create_blogg_categorizations.rb"
        migration_template File.join(migration_template_path,"create_blogg_category_hierarchies.rb"), "db/migrate/create_blogg_category_hierarchies.rb"
        migration_template File.join(migration_template_path,"create_blogg_posts.rb"), "db/migrate/create_blogg_posts.rb"

      end

      def insert_routes
        routes_path = Dir.glob('config/routes.rb').first

        insert_into_file "#{routes_path}", after: "Rails.application.routes.draw do\n" do <<-RUBY
          mount Blogg::Engine => "/administration/blogg"
        RUBY
        end

        insert_into_file "#{routes_path}", after: "resources :administrators\n" do <<-RUBY
          mount Ckeditor::Engine => '/ckeditor'
        RUBY
        end
      end

    end
  end
end
