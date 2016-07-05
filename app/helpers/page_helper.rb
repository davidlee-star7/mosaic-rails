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
      group_variable = variable.present? ? group.groups_variables.where(variable_id: variable.id).first : nil
      value = group_variable.present? ? group_variable.value : ''
    end

    def variable
      variable = group.groups_variables.present? ? Variable.where(identifier: @attributes[:id].to_s).first : nil
    end

    def group
      @additional_attributes[:group]
    end
end

module PageHelper
  def content(c)
    Shortcode.register_presenter(VariablePresenter)
    Shortcode.process(c, { group: group })
  end

  def content_html(c)
     # raw content(c)
     c = c.gsub("<pre>","").gsub("</pre>","")
     Shortcode.register_presenter(VariablePresenter)
     raw Shortcode.process(c, { group: group })
  end

  def group
    current_user.present? && current_user.groups.count > 0 ? current_user.groups.first : nil
  end

  def connect_to_tableau
    post_data = post_data = {
      "username" => "phil@mosaicsustainability.com",
      "password" => "Bison47!",
      "client_ip" => "192.168.100.33"
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

end
