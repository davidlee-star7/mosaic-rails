class MicrositesGroup < ActiveRecord::Base
  belongs_to :group
  belongs_to :microsite

  validates :group_id, :microsite_id, presence: true

  def self.updateMicrosite(params,microsite)
    groups = params[:groups]

     
    if groups != nil
      groups.each do |g|
        g = g.is_a?(Array) ? g.first : g
        if !microsite.groups.exists?(g.to_i)
          mg = MicrositesGroup.new()
          mg.microsite_id = microsite.id
          mg.group_id = g.to_i
          mg.save
        end
      end
    end 

   
    #now remove groups that 
    #was added before but now 
    #would like to remove by 
    #unchecking the checkbox
    microsite.groups.each do |g|
      remove = true
      groups.to_a.each do |pg|
        pg = pg.is_a?(Array) ? pg.first : pg
        if g.id == pg.to_i
          remove = false  
        end
      end
      if remove
        microsite.groups.destroy(g)
      end
    end
    
  end

end
