class ReportsController < ApplicationController
  before_filter :login_required, :except => [:index, :login]
  before_filter :connect_to_tableau, :only => [:iframe,:javascript]

    layout "dashboard"

  def iframe
    @tabpath   = '/views/Gap_Higg_2014_Field_Team&#47;CountryOverview'
    @tabparams = ':embed=yes&:comments=no&:toolbar=no'

    if @ticket != nil
      @tableau_url = "https://mosaic-tableau.com/trusted/#{@ticket}/#{@tabpath}?#{@tabparams}"
    else
      flash[:error] = "#{current_user} does not have access to this page."
      redirect_to access_denied_reports_path
    end
  end

  def javascript
    @tabpath   = "trusted/#{@ticket}/views/Finance/InvestinginDJIA"
  end

  protected
  def login_required
    redirect_to reports_url unless current_user
  end

  def connect_to_tableau
    post_data = post_data = {
      "username" => "phil@mosaicsustainability.com",
      "password" => "Bison47!",
      "client_ip" => "192.168.100.33"
    }
    server = "https://mosaic-tableau.com"
    resp = Net::HTTP.post_form(URI.parse("#{server}/trusted"), post_data)
    @ticket    = resp.body
  end
end
