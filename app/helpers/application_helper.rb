module ApplicationHelper

  
  def bodyfieldincmspage(id) 
    if Template.where(:id => id).present?
      numoffield = Template.find(id).noofinputfields
      numoffield = Template.find(id).noofinputfields
    else
      numoffield = Template.find(2).noofinputfields
    end
  end

  def templatename(id) 
    if Template.where(:id => id).present?
    templatename = Template.find(id).title
    else
    templatename = Template.find(2).title
    end
  end

  def templateid(id) 
    if Template.where(:id => id).present?
    templateid = Template.find(id).id
    else
    templateid = Template.find(2).id
    end
  end


  def gettemplate(id) 
    if Template.where(:id => id).present?
    templaterec = Template.find(id)
    else
    templaterec = Template.find(2)
    end
  end




  def allmicrosites
    if current_user.admin
      @microsite = Microsite.all
    else
      @microsite = Microsite.where(:user_id=> current_user.id)
    end
  end


  def allmicrositesofclient(id)
    if current_user.admin
        @microsite = Microsite.where(:user_id=> id)
    else
        @microsite = Microsite.where(:user_id=> current_user.id)
    end
  end




  def alltemplates 
    @template = Template.all
  end

  def allclients 
      if current_user.admin
        @clients = User.with_role :Client_Admin
    end
  end




  def listUsersofmicrosite(id)
    microsites = Microsite.find(id)
    # @users = microsites.users.where.not(:admin => true)
    @users = microsites.users
    return @users
  end 

  def current_group
    current_user.present? && current_user.groups.count > 0 ? current_user.groups.first : nil
  end

end
