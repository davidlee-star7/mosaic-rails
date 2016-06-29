class Ability
  include CanCan::Ability

  @@listability = [
    { :father => :admin, :child => AdminController.instance_methods(false) },
    { :father => :survey, :child => SurveysController.instance_methods(false) },
    { :father => :section, :child => SectionController.instance_methods(false) },
    { :father => :question, :child => QuestionController.instance_methods(false) },
    { :father => :qfields, :child => QfieldsController.instance_methods(false) },
    { :father => :extrafield, :child => ExtraFieldsController.instance_methods(false) },
    { :father => :filemanager, :child => FileMangersController.instance_methods(false) },
    { :father => :folder, :child => FoldersController.instance_methods(false) },
    { :father => :group, :child => GroupsController.instance_methods(false) },
    { :father => :microsite, :child => MicrositesController.instance_methods(false) },
    { :father => :page, :child => PageController.instance_methods(false) },
    { :father => :cms_page, :child => CmsPagesController.instance_methods(false) },
    { :father => :pagesgroup, :child => PagesGroupsController.instance_methods(false) },
    { :father => :tableau, :child => TableausController.instance_methods(false) },

    { :father => :microsites_groups, :child => MicrositesController.instance_methods(false) },
    
   
    { :father => :survey_groups, :child => SurveyGroupsController.instance_methods(false) },
     
  ]

    def self.abilitycollection
      return @@listability
    end

  def initialize(user)

    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)

      uroles = user.roles

      if user.admin?
         can :manage, :all
       else
         can :read, :all
         
         if uroles != nil

            uroles.each do |ur|
              if ur.permitions != 'nil'

                ur.permitions.each do |urp|
                   
                ## Admin Controller  
                  if urp.action_class == 'admin' && urp.action == 'home'
                   can :home, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'show'
                   can :show, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'index'
                   can :index, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'addUser'
                   can :addUser, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'listUsers'
                   can :listUsers, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'editUser'
                   can :editUser, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'editsurvey'
                   can :editsurvey, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'delUser'
                   can :delUser, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'addSurvey'
                   can :addSurvey, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'buildsurvey'
                   can :buildsurvey, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'manageSurvey'
                   can :manageSurvey, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'listroles'
                   can :listroles, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'editrole'
                   can :editrole, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'updaterole'
                   can :updaterole, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'listRoleCapability'
                   can :listRoleCapability, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'setPermition'
                   can :setPermition, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'importuserscsv'
                   can :importuserscsv, :admin
                  end

                  if urp.action_class == 'admin' && urp.action == 'create_cmspage'
                   can :create_cmspage, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'create_slug'
                   can :create_slug, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'listcmspages'
                   can :listcmspages, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'editpage'
                   can :editpage, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'unlinkcmspage'
                   can :unlinkcmspage, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'update_cmspage'
                   can :update_cmspage, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'clonepage'
                   can :clonepage, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'exportcsv'
                   can :exportcsv, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'importusers'
                   can :importusers, :admin
                  end
                  if urp.action_class == 'admin' && urp.action == 'addexistingpages'
                   can :addexistingpages, :admin
                  end

                  

                  ## Survey Controller 

                  if urp.action_class == 'survey' && urp.action == 'index'
                   can :index, :survey
                  end
                  if urp.action_class == 'survey' && urp.action == 'show'
                   can :show, :survey
                  end
                  if urp.action_class == 'survey' && urp.action == 'new'
                   can :new, :survey
                  end
                  if urp.action_class == 'survey' && urp.action == 'edit'
                   can :edit, :survey
                  end
                  if urp.action_class == 'survey' && urp.action == 'create'
                   can :create, :survey
                  end
                  if urp.action_class == 'survey' && urp.action == 'update'
                   can :update, :survey
                  end
                  if urp.action_class == 'survey' && urp.action == 'destroy'
                   can :destroy, :survey
                  end

                  ## Section Controller

                  if urp.action_class == 'section' && urp.action == 'edit'
                   can :edit, :section
                  end
                  if urp.action_class == 'section' && urp.action == 'update'
                   can :update, :section
                  end
                  if urp.action_class == 'section' && urp.action == 'new'
                   can :new, :section
                  end
                  if urp.action_class == 'section' && urp.action == 'create'
                   can :create, :section
                  end
                  if urp.action_class == 'section' && urp.action == 'delete'
                   can :delete, :section
                  end

                  #
                  # Question Controller
                  #
                  if urp.action_class == 'question' && urp.action == 'new'
                   can :new, :question
                  end
                  if urp.action_class == 'question' && urp.action == 'create'
                   can :create, :question
                  end
                  if urp.action_class == 'question' && urp.action == 'update'
                   can :update, :question
                  end
                  if urp.action_class == 'question' && urp.action == 'edit'
                   can :edit, :question
                  end
                  if urp.action_class == 'question' && urp.action == 'delete'
                   can :delete, :question
                  end

                  #
                  # Qfields Controller
                  #

                  if urp.action_class == 'qfields' && urp.action == 'index'
                   can :index, :question
                  end
                  if urp.action_class == 'question' && urp.action == 'show'
                   can :show, :question
                  end
                  if urp.action_class == 'question' && urp.action == 'new'
                   can :new, :question
                  end
                  if urp.action_class == 'question' && urp.action == 'edit'
                   can :edit, :question
                  end
                  if urp.action_class == 'question' && urp.action == 'create'
                   can :create, :question
                  end
                  if urp.action_class == 'question' && urp.action == 'update'
                   can :update, :question
                  end
                  if urp.action_class == 'question' && urp.action == 'destroy'
                   can :destroy, :question
                  end

                  #
                  # Tableau Controller
                  #

                  if urp.action_class == 'tableau' && urp.action == 'index'
                   can :index, :tableau
                  end
                  if urp.action_class == 'tableau' && urp.action == 'show'
                   can :show, :tableau
                  end
                  if urp.action_class == 'tableau' && urp.action == 'new'
                   can :new, :tableau
                  end
                  if urp.action_class == 'tableau' && urp.action == 'edit'
                   can :edit, :tableau
                  end
                  if urp.action_class == 'tableau' && urp.action == 'create'
                   can :create, :tableau
                  end
                  if urp.action_class == 'tableau' && urp.action == 'update'
                   can :update, :tableau
                  end
                  if urp.action_class == 'tableau' && urp.action == 'destroy'
                   can :destroy, :tableau
                  end

                  #
                  # Page Controller
                  #

                  if urp.action_class == 'page' && urp.action == 'login'
                   can :login, :page
                  end
                  if urp.action_class == 'page' && urp.action == 'logout'
                   can :logout, :page
                  end
                  if urp.action_class == 'page' && urp.action == 'show'
                   can :show, :page
                  end
                  if urp.action_class == 'page' && urp.action == 'index'
                   can :index, :page
                  end
                  if urp.action_class == 'page' && urp.action == 'client_dashboard'
                   can :client_dashboard, :page
                  end
                  if urp.action_class == 'page' && urp.action == 'enterotp'
                   can :enterotp, :page
                  end
                  if urp.action_class == 'page' && urp.action == 'check_two_factor_authentication'
                   can :check_two_factor_authentication, :page
                  end
                  if urp.action_class == 'page' && urp.action == 'cms'
                   can :cms, :page
                  end
                  if urp.action_class == 'page' && urp.action == 'unpublished'
                   can :unpublished, :page
                  end
                  if urp.action_class == 'page' && urp.action == 'unpublished'
                   can :unpublished, :page
                  end
                  if urp.action_class == 'page' && urp.action == 'preview_microsite'
                   can :preview_microsite, :page
                  end

                  #
                  #cms_page_controller
                  #

                  if urp.action_class == 'cms_page' && urp.action == 'managegroup'
                   can :managegroup, :cms_page
                  end
                  if urp.action_class == 'cms_page' && urp.action == 'autocomplete_cms_page_title'
                   can :autocomplete_cms_page_title, :cms_page
                  end
                  if urp.action_class == 'cms_page' && urp.action == 'get_autocomplete_order'
                   can :get_autocomplete_order, :cms_page
                  end
                  if urp.action_class == 'cms_page' && urp.action == 'get_autocomplete_items'
                   can :get_autocomplete_items, :cms_page
                  end
                  if urp.action_class == 'cms_page' && urp.action == 'get_prefix'
                   can :get_prefix, :cms_page
                  end

                  
                 

                  

                   # cms_page Controller 
                  if urp.action_class == 'cms_pages' && urp.action == 'managegroup'
                   can :managegroup, :cms_pages
                  end

                  #
                  # microsite Controller
                  #
                  if urp.action_class == 'microsite' && urp.action == 'index'
                   can :index, :microsite
                  end
                  if urp.action_class == 'microsite' && urp.action == 'show'
                   can :show, :microsite
                  end
                  if urp.action_class == 'microsite' && urp.action == 'new'
                   can :new, :microsite
                  end
                  if urp.action_class == 'microsite' && urp.action == 'edit'
                   can :edit, :microsite
                  end
                  if urp.action_class == 'microsite' && urp.action == 'create'
                   can :create, :microsite
                  end
                  if urp.action_class == 'microsite' && urp.action == 'update'
                   can :update, :microsite
                  end
                  if urp.action_class == 'microsite' && urp.action == 'destroy'
                   can :destroy, :microsite
                  end     
                  if urp.action_class == 'microsite' && urp.action == 'unlinkmicrosite'
                   can :unlinkmicrosite, :microsite
                  end    
                  if urp.action_class == 'microsite' && urp.action == 'listpagesbymicrositeandgroup'
                   can :listpagesbymicrositeandgroup, :microsite
                  end    
                  if urp.action_class == 'microsite' && urp.action == 'get_autocomplete_order'
                   can :get_autocomplete_order, :microsite
                  end  
                   if urp.action_class == 'microsite' && urp.action == 'addexistingmicrositestogroups'
                   can :addexistingmicrositestogroups, :microsite
                  end  
                   if urp.action_class == 'microsite' && urp.action == 'addexistingpages'
                   can :addexistingpages, :microsite
                  end  


                  #
                  # group Controller
                  #

                  if urp.action_class == 'group' && urp.action == 'index'
                   can :index, :group
                  end
                  if urp.action_class == 'group' && urp.action == 'show'
                   can :show, :group
                  end
                  if urp.action_class == 'group' && urp.action == 'new'
                   can :new, :group
                  end
                  if urp.action_class == 'group' && urp.action == 'edit'
                   can :edit, :group
                  end
                  if urp.action_class == 'group' && urp.action == 'create'
                   can :create, :group
                  end
                  if urp.action_class == 'group' && urp.action == 'update'
                   can :update, :group
                  end
                  if urp.action_class == 'group' && urp.action == 'destroy'
                   can :destroy, :group
                  end    
                  if urp.action_class == 'group' && urp.action == 'unlink_user'
                   can :unlink_user, :group
                  end
                  if urp.action_class == 'group' && urp.action == 'addExistingUsers'
                   can :addExistingUsers, :group
                  end
                  if urp.action_class == 'upload_users' && urp.action == 'upload_users'
                   can :update, :group
                  end

                  #
                  # microsite group Controller
                  #

                  if urp.action_class == 'microsites_groups' && urp.action == 'index'
                   can :index, :microsites_groups
                  end
                  if urp.action_class == 'microsites_groups' && urp.action == 'show'
                   can :show, :microsites_groups
                  end
                  if urp.action_class == 'microsites_groups' && urp.action == 'new'
                   can :new, :microsites_groups
                  end
                  if urp.action_class == 'microsites_groups' && urp.action == 'edit'
                   can :edit, :microsites_groups
                  end
                  if urp.action_class == 'microsites_groups' && urp.action == 'create'
                   can :create, :microsites_groups
                  end
                  if urp.action_class == 'microsites_groups' && urp.action == 'update'
                   can :update, :microsites_groups
                  end
                  if urp.action_class == 'microsites_groups' && urp.action == 'destroy'
                   can :destroy, :microsites_groups
                  end 

                  if urp.action_class == 'microsites_groups' && urp.action == 'unlinkmicrosite'
                   can :unlinkmicrosite, :microsites_groups
                  end
                  if urp.action_class == 'microsites_groups' && urp.action == 'listpagesbymicrositeandgroup'
                   can :listpagesbymicrositeandgroup, :microsites_groups
                  end
                  if urp.action_class == 'microsites_groups' && urp.action == 'addexistingmicrositestogroups'
                   can :addexistingmicrositestogroups, :microsites_groups
                  end                      

                  #
                  # pagesgroup Controller
                  #
                  if urp.action_class == 'pagesgroup' && urp.action == 'index'
                   can :index, :pagesgroup
                  end
                  if urp.action_class == 'pagesgroup' && urp.action == 'show'
                   can :show, :pagesgroup
                  end
                  if urp.action_class == 'pagesgroup' && urp.action == 'new'
                   can :new, :pagesgroup
                  end
                  if urp.action_class == 'pagesgroup' && urp.action == 'edit'
                   can :edit, :pagesgroup
                  end
                  if urp.action_class == 'pagesgroup' && urp.action == 'create'
                   can :create, :pagesgroup
                  end
                  if urp.action_class == 'pagesgroup' && urp.action == 'update'
                   can :update, :pagesgroup
                  end
                  if urp.action_class == 'pagesgroup' && urp.action == 'destroy'
                   can :destroy, :pagesgroup
                  end  

                  

                  #
                  # survey_group Controller
                  #
                  if urp.action_class == 'survey_groups' && urp.action == 'index'
                   can :index, :survey_groups
                  end
                  if urp.action_class == 'survey_groups' && urp.action == 'show'
                   can :show, :survey_groups
                  end
                  if urp.action_class == 'survey_groups' && urp.action == 'new'
                   can :new, :survey_groups
                  end
                  if urp.action_class == 'survey_groups' && urp.action == 'edit'
                   can :edit, :survey_groups
                  end
                  if urp.action_class == 'survey_groups' && urp.action == 'create'
                   can :create, :survey_groups
                  end
                  if urp.action_class == 'survey_groups' && urp.action == 'update'
                   can :update, :survey_groups
                  end
                  if urp.action_class == 'survey_groups' && urp.action == 'destroy'
                   can :destroy, :survey_groups
                  end  
                  if urp.action_class == 'survey_groups' && urp.action == 'addexistingsurveystogroups'
                   can :survey_groups, :addexistingsurveystogroups
                  end
                  if urp.action_class == 'survey_groups' && urp.action == 'unlinkgroup'
                   can :survey_groups, :unlinkgroup
                  end
                   
                    



                 # end 2nd loop 
                end
                # end 1st loop
              end
              #end 2nd nil if
            end

          else

            can :read, :all

           # end 1st nill if
         end
       #  can :manage, :all 
       can :home, :admin # 
       can :unauthorised, :admin
       can :home, :show
     end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end


end
