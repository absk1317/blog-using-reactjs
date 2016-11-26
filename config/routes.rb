Rails.application.routes.draw do
  root 'blogs#index'
  get 'blogs/all' => 'blogs#all_blogs'
  get 'blogs/:id/comments' => 'blogs#comments'
  post '/comments' => 'comments#create'
  put 'comments/:id' => 'comments#update'
  delete 'comments/:id' => 'comments#delete'
  resources :blogs
end
