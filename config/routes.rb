Rails.application.routes.draw do
  resources :urls, only: %i[create show] do
    resources :stats, only: %i[index], module: :urls
  end

  resources :requests, only: %i[index]
end
