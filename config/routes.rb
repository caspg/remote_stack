Rails.application.routes.draw do
  root to: 'home#index'
  get '/', to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'jobs/:id', to: 'job_posts#show', as: :job_posts

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace 'admin' do
    resources 'scrapers', only: [:create]
  end
end
