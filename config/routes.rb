Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#index'

  get '/user_profiles/edit/intersts/', to: 'user_profiles#edit_intersts', as: :edit_user_intersts
  put '/user_profiles/edit/intersts/', to: 'user_profiles#update_intrests', as: :edit_user_intersts_request

  get '/user_profiles/edit/', to: 'user_profiles#edit', as: :edit_user_profile
  put '/user_profiles/edit/', to: 'user_profiles#update', as: :edit_user_profile_request

  get '/user_profiles/:id/', to: 'user_profiles#show', as: :show_user_profile  
  get '/user_profiles/', to: 'user_profiles#show', as: :current_user_profile  

  get '/conversations/', to: 'conversations#index', as: :my_conversations
  put '/conversation/', to: 'conversations#create', as: :conversation
  
  get '/messages/' , to: 'messages#index' , as: :conversation_messages
  put '/messages/create' , to: 'messages#create' , as: :create_new_message

  get '/tags/' , to: 'tags#index' , as: :all_tags
  put '/tags/create' , tp: 'tags#create' , as: :create_new_tag

  get '/mischievous/', to: 'pages#mischievous' , as: :dont_do_mischievous
end
