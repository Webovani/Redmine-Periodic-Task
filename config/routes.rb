ActionController::Routing::Routes.draw do |map|
  map.resources :projects do |project|
    project.resources :periodic_tasks
  end
end