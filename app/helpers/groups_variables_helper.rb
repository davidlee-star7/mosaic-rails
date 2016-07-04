module GroupsVariablesHelper
  def variable_names_collection
    Variable.all.map{ |variable| 
      [variable.name, variable.id]
    }
  end
end
