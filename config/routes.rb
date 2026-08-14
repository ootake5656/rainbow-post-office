Rails.application.routes.draw do
  root "static_pages#top"

  resources :users, only: %i[new create]
  resources :pets, only: %i[new create] do
    collection do   # ログイン中のユーザーからPetを探すので別のユーザーのPet IDを入力される危険を減らす
      get :owner_call_name    # 入力画面を表示する
      # PetsController#owner_call_nameへつながる
      patch :owner_call_name, action: :update_owner_call_name
      # 入力された呼び名を送信する
      # PetsController#update_owner_call_nameへつながる
      # 既存のPetを更新するためPOSTではなくPATCHを使う
    end
  end

  resources :letters, only: :new do
    collection do
      post :confirm
      get :confirmation
      post :send_letter
      patch :draft, action: :save_draft
      delete :draft, action: :destroy_draft
    end
  end

  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"

  resource :mypage, only: :show

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
