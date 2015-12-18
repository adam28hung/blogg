Blogg::Engine.routes.draw do

  namespace :backend do
    root to: "posts#index"

    resources :posts
    resources :categories
  end

  scope module: 'frontend' do
    root to: "posts#index"
    resources :posts do
      collection do
        get 'tags/:tag', to: 'posts#tag', as: :tag
      end
    end
    resources :categories
  end

end
