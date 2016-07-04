module VariablesHelper
  def get_shortcode(variable)
    "[variable id=\"#{variable.identifier}\"][/variable]"
  end

  def variable_type_collection
    Variable::Types.map { |item, key| 
      [key, item]
    }
  end
end
