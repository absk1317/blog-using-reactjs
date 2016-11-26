Rails.application.routes.draw do
  root 'blogs#index'
  get 'blogs/all' => 'blogs#all_blogs'
  resources :blogs
end
