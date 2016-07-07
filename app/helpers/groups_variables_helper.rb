module GroupsVariablesHelper
  def variable_names_collection
    Variable.all.map{ |variable| 
      [variable.name, variable.id]
    }
  end

  def value_field_type(variable)
    result = case variable.vtype
      when 'image'
        'image'
      when 'file'
        'file'
      else
        'text'
      end
  end
end
