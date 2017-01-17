module VariablesHelper
  def variable_names_collection
    Variable.all.map{ |variable| 
      [variable.name, variable.id]
    }
  end
  
  def get_shortcode(variable)
    "[variable id='#{variable.identifier}'][/variable]"
  end

  def variable_type_collection
    Variable::Types.map { |item, key| 
      [key, item]
    }
  end
end
