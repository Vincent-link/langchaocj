
Rails.application.routes.draw do
    devise_for :users, controllers: { registrations: 'users/registrations' }

    namespace :admin do
        resources :jobs do
            member do
                post :publish
                post :hide
            end
            resources :resumes
        end
    end

    resources :jobs do
        resources :resumes
    end

    resources :search do
        member do
            get :search
        end
    end

    root 'welcome#index'
end
