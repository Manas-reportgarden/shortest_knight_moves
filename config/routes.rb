Rails.application.routes.draw do
  resources :knights, only: :none do
    collection do
      get :get_shortest_path
    end
  end

  resources :chess_boards, only: :create
end
