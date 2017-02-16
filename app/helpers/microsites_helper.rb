module MicrositesHelper
  def microsite_titles_collection
    Microsite.all.map{ |microsite| 
      [microsite.title, microsite.id]
    }
  end
end
