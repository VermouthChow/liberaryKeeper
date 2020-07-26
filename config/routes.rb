Rails.application.routes.draw do
  scope '/api/v1/', defaults: { format: :json } do
    resources :users, only: [:show, :create] do
      member do
        post 'borrow_books'
        post 'return_books'
      end
    end

    resources :books, only: [:show, :create] do
      get 'check_out_detail', on: :collection
    end

    resources :transition_records, only: :index

    resources :check_out_records, only: :index
  end
end
