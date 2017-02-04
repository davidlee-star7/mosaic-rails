class MoveToRowsFromFields < ActiveRecord::Migration
  def up
    CmsPage.all.each do |page|
      pos = 0
      ExtraField.where(cms_page_id: page.id).order(:id).group_by(&:field_group).each do |key, group|
        if key.present? && group.present?
          pos = pos + 1
          row = ExtraRow.new(cms_page_id: page.id, row_name: group[0][:field_name], position: pos)
          row.save
          ExtraField.where(cms_page_id: page.id, field_group: key).update_all(extra_row_id: row.id)
        end
      end
    end
  end

end
