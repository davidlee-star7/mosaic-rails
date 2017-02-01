Rails.application.routes.draw do

  resources :uploaded_files

  resources :tableau_users

  resources :tableaus, path: '/tableau-dashboards'

  resources :extra_fields
  post 'extra_fields/add_fields_by_group' => 'extra_fields#add_fields_by_group'
  get 'extra_fields/remove_by_grop/:group_id' => 'extra_fields#remove_by_grop'

  resources :pages_groups

  resources :microsites_groups

  get 'microsites_groups/unlinkmicrosite/:microsite_id/:group_id' => 'microsites_groups#unlinkmicrosite'

  get 'microsites_groups/addexistingmicrositestogroups/:group_id' => 'microsites_groups#addexistingmicrositestogroups'
  patch 'microsites_groups/addexistingmicrositestogroups/:group_id' => 'microsites_groups#addexistingmicrositestogroups'
  get 'microsites_groups/listpagesbymicrositeandgroup/:microsite_id/:group_id' => 'microsites_groups#listpagesbymicrositeandgroup'
  get 'microsites/unlink_client/:microsite_id/:client_id' => 'microsites#unlink_client'
  get 'microsites/:id/:pid/default_page' => 'microsites#default_page'


  resources :survey_groups
  get 'survey_groups/addexistingsurveystogroups/:group_id' => 'survey_groups#addexistingsurveystogroups'
  patch 'survey_groups/addexistingsurveystogroups/:group_id' => 'survey_groups#addexistingsurveystogroups'
  get 'survey_groups/unlinkgroup/:survey_id/:group_id' => 'survey_groups#unlinkgroup'

  resources :groups do
    get :autocomplete_group_name, :on => :collection
    get :autocomplete_user_username, :on => :collection

    get 'upload_users' 
    post 'upload_users'
    get 'unlink_user/:user_id' => 'groups#unlink_user'
    # get 'addExistingUsers'
    patch 'addExistingUsers'

    resources :variables, controller: :groups_variables
  end
  #get "groups/autocomplete"
  # resources :folders
  # resources :file_mangers
  get 'file_mangers/all_files'

  get 'file_mangers/new_file'

  post 'file_mangers/create_file'

  resources :folders do
    resources :file_mangers
  end

  scope '/client' do
    get 'dashboard/:id' => 'page#client_dashboard'
    get 'tableau/:id/:task' => 'page#client_dashboard'
    get 'tableau/ticket' => 'page#client_dashboard'
    get ':id'=> 'admin#showClient'
    patch ':id' => 'admin#showClient'
  end

  scope '/take' do 
    get 'surveys' => 'played_surveys#surveys'
    get 'survey/:survey_id' => 'played_surveys#survey'
    get 'survey/:survey_id/:section_id' => 'played_surveys#survey'
    patch 'savesurvey/:section_id' => 'played_surveys#savesurvey'
  end

  resources :microsites do
    get :autocomplete_microsite_title, :on => :collection     
    member do

      get 'newcmspage/:template_id' => 'admin#newcmspage'
      
      get 'addexistingsurveys' => 'admin#addexistingsurveys'
      patch 'addexistingsurveys' => 'admin#addexistingsurveys'

      post 'create_cmspage' => 'admin#create_cmspage'
      patch 'create_cmspage' => 'admin#create_cmspage'
      get 'editpage/:cms_page_id/:template_id' => 'admin#editpage'
      patch 'update_cmspage/:cms_page_id' => 'admin#update_cmspage'

      get 'addexistingpages' => 'microsites#addexistingpages'
      patch 'addexistingpages' => 'microsites#addexistingpages'
      get 'unlinkcmspage/:page_id' => 'microsites#unlinkcmspage'

    end
  end

  resources :surveys do
    get :autocomplete_survey_name, :on => :collection 
  end
 
  post 'microsites/index' => 'microsites#index'
  get 'page/unpublished'

  mount Ckeditor::Engine => '/ckeditor'
  resources :played_surveys

  get 'page/show'
  resources :qfields
  get 'question/new/:section_id' =>'question#new'
  post 'question/new'
  post 'question/create'

  post 'qfield/delete/:id' => 'qfields#destroy'

  get 'admin/listroles' => 'admin#listroles'

  get 'admin/clients' => 'admin#listClients'

  get 'admin/editrole/:id/:role_id' => 'admin#editrole'

  patch 'admin/:id/updaterole' => 'admin#updaterole'

  get 'admin/listRoleCapability/:id/:role_id' => 'admin#listRoleCapability'

  post 'admin/setPermition/:id/:role_id' => 'admin#setPermition'

  get 'admin/unauthorised' => 'admin#unauthorised'

  get 'admin/taken_surveys' => 'admin#played_surveys'

  get 'question/field_type' => 'question#field_type'

  post 'question/field_type' => 'question#field_type'

  # process csv
  get 'admin/importuserscsv' => 'admin#importuserscsv'
  post 'admin/processuserscsv' => 'admin#processuserscsv'

  post 'admin/importusers' => 'admin#importusers'

  get 'admin/exportcsv' => 'admin#exportcsv'
  get 'admin/exportxls' => 'admin#exportxls'
  # for page controller

  get 'admin/assign_survey' => 'admin#assign_survey_to_users'
  post 'admin/sending_group_invitation_users' => 'admin#sending_group_invitation_users'
 
  post '/admin/assign_survey_to_microsite' => 'admin#assign_survey_to_microsite'

  get 'admin/clients/new' => 'admin#newclient'
  get 'admin/clients/:id/edit' => 'admin#editclient'
  patch 'admin/clients/create' => 'admin#createclient'
  patch 'admin/clients/update' => 'admin#updateclient'

 
  
  resources :section
  resources :question
  resources :page
  resources :cms_page

  resources :cms_pages do
    get :autocomplete_cms_page_title, :on => :collection  
   post 'managegroup/:group_id' => 'cms_pages#managegroup'
  end


  resources :reports do
    collection do
      get :iframe
      get :javascript
      post :login
      get :logout
      get :access_denied
    end
  end

    

  post 'section/update/:id' => 'section#update'
  post 'section/create/:id' => 'section#create'
  get 'section/:id/new' => 'section#new'
  get 'section/:id/delete' => 'section#delete'

  get 'admin/microsites/:client_id' => 'admin#microsites'


  

  get 'question/:id/new' => 'question#new'

  ###change to update##
  post 'question/update' => 'question#update'

  get 'question/:id/delete/:survey_id' => 'question#delete'

  get 'question/:id/edit/:survey_id' => 'question#edit'
  post 'question/:id/edit/:survey_id' => 'question#edit'

  get 'admin/:id/editsurvey' => 'admin#editsurvey'
  get 'surveys/:id/destroy' => 'surveys#destroy'
  post 'surveys/:id/update' => 'surveys#update'

  get 'admin/clonepage/:page_id' => 'admin#clonepage'
  delete 'admin/deletepage/:page_id' => 'admin#deletepage'
  
  get  'surveyresults' => 'admin#survey_results'

 
  get 'admin/home' => 'admin#home'

  # define resurce for users
  # at admin dashboard 
  get 'admin/users' => 'admin#listUsers'
  put 'admin/edit_user_individual' => 'admin#edit_user_individual'
  post 'admin/bulkupdaterole'  =>  'admin#bulkupdaterole'
  get 'admin/delUser/:id' => 'admin#delUser'
  post 'admin/sendinvitationuser'  =>  'admin#sendinvitationuser'


  get 'admin/addUser', to: 'admin#addUser'
  post 'admin/addUser', to: 'admin#addUser'

  get 'admin/editUser/:id', to:'admin#editUser', as: :admin_editUser
  post 'admin/editUser/:id', to:'admin#editUser'

  get 'admin/upload_users', to: 'admin#upload_users'
  post 'admin/upload_users', to: 'admin#upload_users'

  # define resurse for 
  # survey at admin
  get 'admin/addSurvey', to: 'admin#addSurvey'
  get 'admin/addSurvey/:client_id', to: 'admin#addSurvey'
  post 'admin/addSurvey', to: 'admin#addSurvey'
  get 'admin/manageSurvey', to: 'admin#manageSurvey'
  post 'admin/manageSurvey', to: 'admin#manageSurvey'
  get 'admin/buildsurvey/:id', to: 'admin#buildsurvey'
  get 'admin/survey_exports/:id', to: 'admin#survey_exports'
  get 'admin/unlinksurvey/:survey_id/:microsite_id', to: 'admin#unlinksurvey'

  resources :ext_users do
    resources :variables, controller: 'users_variables'
  end

  #devise_for :users
  get 'two_factor_authentication', to: 'page#enterotp'
  get '/confirm/:id/:otp', to: 'page#check_two_factor_authentication'
  put 'check_two_factor_authentication', to: 'page#check_two_factor_authentication'
  post 'check_two_factor_authentication', to: 'page#check_two_factor_authentication'


  root 'admin#home' 
  #
  devise_for :users, controllers: {  
      registrations:'users/registrations',
      sessions:'users/sessions',
      passwords:'users/passwords',
      confirmations:'users/confirmations',
      mailer:'users/mailer',
      shared:'users/shared',
      invitations:'users/invitations'
  }  do


  post 'two_factor_authentication' => 'users/sessions#check_two_factor_authentication'

  end
  
  resources :variables  

  # resources :registrations do
    
  # end
 

  get 'admin/accessmanage' => 'admin#accessmanage'

  #create CMS pages
  post 'admin/create_slug' => 'admin#create_slug'
  get 'admin/newcmspage' => 'admin#newcmspage'
  get 'admin/newcmspage/:template_id' => 'admin#newcmspage'

  post 'admin/create_cmspage' => 'admin#create_cmspage'
  patch 'admin/create_cmspage' => 'admin#create_cmspage'

  get 'admin/listcmspages' => 'admin#listcmspages'
  post 'admin/listcmspages' => 'admin#listcmspages'
  get 'admin/editpage/:cms_page_id' => 'admin#editpage'

  get 'page_col/add_row/:page_id' => 'page#add_row'
  patch 'admin/update_cmspage/:cms_page_id' => 'admin#update_cmspage'
  get ':client_slug/:microsite_slug' => 'page#preview_microsite', as: :client_microsite
  get ':client_slug/:microsite_slug/:cms_page_slug' => 'page#preview_microsite'
  get ':slug' => 'page#cms'
  get ':slug/:type' => 'page#cms' 


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', 
  #as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
    # resources :products do
    #   member do
    #     get 'sam'
    #  end
  
    #   collection do
    #     get 'china'
    #   end
    # end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end



end
