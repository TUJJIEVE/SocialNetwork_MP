Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#index'
  resources :questions
  get '/users/search/' , to: 'pages#searchUsers' , as: :search_users  
  
  #friends
  get '/users/send_request/', to: 'friends#sendRequest' , as: :send_request
  get '/users/accept_request/', to: 'friends#acceptRequest' , as: :accept_request
  get '/users/reject_request/', to: 'friends#rejectRequest' , as: :reject_request
  get '/users/rejected_requests/', to: 'friends#rejectedRequests' , as: :rejected_requests
  get '/users/pending_requests/', to: 'friends#pendingRequests' , as: :pending_requests
  get '/users/accept_requests/', to: 'friends#acceptRequests' , as: :accept_requests
  get '/users/friends/' ,to: 'friends#all' , as: :all_friends

  #user intrests
  get '/user_profiles/edit/intersts/', to: 'user_profiles#edit_intersts', as: :edit_user_intersts
  put '/user_profiles/edit/intersts/', to: 'user_profiles#update_intrests', as: :edit_user_intersts_request

  #user profile
  get '/user_profiles/edit/', to: 'user_profiles#edit', as: :edit_user_profile
  put '/user_profiles/edit/', to: 'user_profiles#update', as: :edit_user_profile_request

  get '/user_profiles/:id/', to: 'user_profiles#show', as: :show_user_profile  
  get '/user_profiles/', to: 'user_profiles#show', as: :current_user_profile  

  #conversations
  get '/conversations/', to: 'conversations#index', as: :my_conversations
  put '/conversation/', to: 'conversations#create', as: :conversation
  
  #messages
  get '/messages/' , to: 'messages#index' , as: :conversation_messages
  put '/messages/create' , to: 'messages#create' , as: :create_new_message

  #tags
  get '/tags/' , to: 'tags#index' , as: :all_tags
  put '/tags/create' , tp: 'tags#create' , as: :create_new_tag

  #misselienous
  get '/mischievous/', to: 'pages#mischievous' , as: :dont_do_mischievous
end
