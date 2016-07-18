module UsersVariablesHelper
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