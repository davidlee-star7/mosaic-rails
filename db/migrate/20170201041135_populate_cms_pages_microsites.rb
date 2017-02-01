class PopulateCmsPagesMicrosites < ActiveRecord::Migration
  def up
    CmsPage.find_each do |page|
      microsite = Microsite.find(page.microsite_id) if page.microsite_id.present?
      if microsite.present?
        page.microsites << microsite unless page.microsites.include?(microsite)
      end
    end
  end

  def down
  end
end
