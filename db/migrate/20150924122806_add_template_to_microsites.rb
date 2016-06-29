class AddTemplateToMicrosites < ActiveRecord::Migration
  def change
    add_reference :microsites, :template, index: true
    add_foreign_key :microsites, :templates
  end
end
