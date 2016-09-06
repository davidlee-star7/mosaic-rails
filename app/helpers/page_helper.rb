class VariablePresenter

  def self.for
    :variable
  end

  def initialize(attributes, content, additional_attributes)
    @content = content
    @attributes = attributes
    @additional_attributes = additional_attributes
  end

  def content
    @content
  end

  def attributes
    @attributes[:value] = value
    @attributes[:type] = variable.present? ? variable.vtype : ''
    @attributes
  end

  private
    def value
      user_value ? user_value : group_value
    end

    def user_value
      user_variable = variable.present? ? user.users_variables.where(variable_id: variable.id).first : nil
      value = user_variable.present? ? user_variable.value : ''
    end

    def group_value
      group_variable = variable.present? ? group.groups_variables.where(variable_id: variable.id).first : nil
      value = group_variable.present? ? group_variable.value : ''
    end

    def variable
      variable = group.groups_variables.present? ? Variable.where(identifier: @attributes[:id].to_s).first : nil
    end

    def group
      @additional_attributes[:group]
    end

    def user
      @additional_attributes[:user]
    end
end

class ProjectPresenter
  require 'uri'

  def self.for
    :project
  end

  def initialize(attributes, content, additional_attributes)
    @content = content
    @attributes = attributes
    @additional_attributes = additional_attributes
  end

  def content
    @content
  end

  def attributes
    @attributes[:filter] = filter
    @attributes[:user] = user
    @attributes
  end

  private

    def filter
      variables = user_variables.present? ? user_variables : group_variables
      if variables.present?
        filter_ary = variables.inject([]) do |filter_ary, gv|
          filter_ary + ["#{gv.variable.identifier}=#{gv.value}"]
        end
        filter_str = URI::escape(filter_ary.join('&'))
      else
        filter_str = ''
      end
      filter_str
    end
    
    def user
      @additional_attributes[:user]
    end

    def group
      @additional_attributes[:group]
    end

    def user_variables
      user.present? ? user.users_variables.joins(:variable).where('variables.vtype=?', 'tableau_url_appendage') : nil
    end

    def group_variables
      group.present? ? group.groups_variables.joins(:variable).where('variables.vtype=?', 'tableau_url_appendage') : nil
    end
end

class FileuploaderPresenter

  def self.for
    :fileuploader
  end

  def initialize(attributes, content, additional_attributes)
    @content = content
    @attributes = attributes
    @additional_attributes = additional_attributes
  end

  def content
    @content
  end

  def attributes

    @attributes
  end

end

module PageHelper
  def content(c)
    Shortcode.register_presenter(VariablePresenter)
    Shortcode.register_presenter(ProjectPresenter)
    Shortcode.register_presenter(FileuploaderPresenter)
    Shortcode.process(c, { user: current_user, group: current_group })
  end

  def content_html(c)
    # raw content(c)
    c = c.gsub("<pre>","").gsub("</pre>","")
    Shortcode.register_presenter(VariablePresenter)
    Shortcode.register_presenter(ProjectPresenter)
    Shortcode.register_presenter(FileuploaderPresenter)
    raw Shortcode.process(c, { user: current_user, group: current_group })
  end

  def connect_to_tableau
    tableau_username = "phil@mosaicsustainability.com"
    user = @attributes[:user]
    if user.present? && user.tableau_user.present?
      tableau_username = user.tableau_user.username
    end
    post_data = {
      "username" => tableau_username,
      # "password" => "Bison47!",
      "client_ip" => "50.112.88.230"
    }
    server = "https://mosaic-tableau.com"
    resp = Net::HTTP.post_form(URI.parse("#{server}/trusted"), post_data)
    return resp.body
  end

   #
  def list_row_type
    [
      {:id => 1,  :row_type =>"1",                :name => "one column"},
      {:id => 2,  :row_type => "1/2,1/2",         :name => "two half column"},
      {:id => 3,  :row_type => "1/2,1/4,1/4",     :name => "one half, two quarter"},
      {:id => 4,  :row_type => "1/4,1/4,1/2",     :name => "two quarter, one half"},
      {:id => 5,  :row_type => "1/4,1/4,1/4,1/4", :name => "four quarter"},
      {:id => 6,  :row_type => "2/3,1/3",         :name => "one two third and one one third column"},
      {:id => 7,  :row_type => "1/3,2/3",         :name => "one one third and one two third"},
      {:id => 8,  :row_type => "1/3,1/3,1/3",     :name => "three  one third column"}
    ]
  end

  def nest_pages(microsite, parent_id = nil)
    if parent_id.nil?
      microsite.cms_pages.where("parent_id IS NULL")
    else
      microsite.cms_pages.where(parent_id: parent_id)
    end
  end
end
