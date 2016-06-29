require 'rake'
namespace :microsite_task do
  desc "Save all Microsite"
  task :save => :environment do
    puts "--- Saving Microsite ---"
    Microsite.find_each(&:save)
    puts "All Microsite have been saved.\n"
  end
end