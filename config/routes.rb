Blogg::Engine.routes.draw do

  namespace :backend do
    root to: "posts#index"

    resources :posts
    resources :categories
  end

  scope module: 'frontend' do
    root to: "posts#index"
    resources :posts
  end

end
