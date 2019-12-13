Rails.application.routes.draw do

  get '/' => 'welcome#index'

  # Admin page - admin authentication
  get  'admin' => 'admin#home'
  post 'admin/login'
  get  'admin/logout' => 'admin#logout'
  
  # Admin page - admin actions
  get  'admin/welcome' => 'admin#welcome'
  get  'admin/close_form'
  get  'admin/open_form'

  get  'admin/update_settings'
  post 'admin/update_settings' => 'admin#update_settings_post'

  get  'admin/generate_matches' => 'admin#generate_matches'
  get  'admin/results'
  
  get 'admin/display_database' => 'admin#display_database'

  get  'admin/reset_database'
  post 'admin/confirm_reset_database' => 'admin#confirm_reset_database'

  get 'admin/reset_matching'

  # Forms
  get  '/forms' => 'forms#index'
  # Teacher
  get  'forms/teacher'
  post 'forms/teacher' => 'forms#teacher'
  post 'forms/teacher_submit' => 'forms#teacher_submit'
  # Tutor
  get  'forms/tutor'
  post 'forms/tutor' => 'forms#tutor'
  post 'forms/tutor_submit' => 'forms#tutor_submit'
  # Parent
  get  'forms/parent'
  post 'forms/parent_submit' => 'forms#parent_submit'
  
  # Errors
  get '/403' => 'errors#permission_denied'
  get '/404' => 'errors#not_found'
  get '/422' => 'errors#unacceptable'
  get '/500' => 'errors#internal_error'

  # Any other route goes to 404
  # get '*a' => redirect("/404")
end
