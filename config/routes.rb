require 'api_version_constraint'

Rails.application.routes.draw do

  devise_for :users, only: [:sessions], controllers: { session: 'api/v1/sessions' }

  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1, default: true) do
      resources :users, only: [:show, :create, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
    end
  end

end
