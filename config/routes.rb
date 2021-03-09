Rails.application.routes.draw do
  resources :urls, only: %i[create show] do
    resources :stats, only: %i[index]
  end

  # namespace :urls do
  # end

  resources :requests, only: %i[index]
end
