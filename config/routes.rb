Rails.application.routes.draw do
  devise_for :users, controllers:{
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: "users/sessions"}
  root 'items#index'
  
  #items関係
  resources :items do
    resources :purchases, only: [:new, :create]
    resource :likes, only: [:create, :destroy]
    member do
      get :seller
    end
    collection do
      get :set_children
      get :set_grandchildren
      get :brand
    end
  end

  #users関係
  resources :users, only: [:show, :edit, :update] do
    member do
      get :logout
      get :selling
    end
  end

  #credits関係
  resources :credits, only: [:new]

  #devise関係
  resources :registrations, only: [:new, :edit, :update] do
    collection do
      get :new1
      get :new1_1
      get :new2
      get :new3
      get :new4
      get :new5
      get :new6
    end
    collection do
      post :create1
      post :create1_1
      post :create2
      post :create3
      post :create4
      post :create5
    end
  end

  resources :sessions, only: [:new]

  #search関係
  namespace :searches do
    get :fuzzy_search
    get :detail_search
  end
end