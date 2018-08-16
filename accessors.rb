# module for dynamic generation setters and getters
module Accessors
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        hkey = "#{var_name}_history".to_sym
        hval = instance_variable_get(hkey) || []
        hval << value
        instance_variable_set(hkey, hval)
        instance_variable_set(var_name, value)
      end
      define_method("#{name}_history".to_sym) do
        instance_variable_get("#{var_name}_history".to_sym)
      end
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def strong_attr_accessor(name, type)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=") do |value|
      raise 'Type is not correct' unless value.is_a?(type)
      instance_variable_set(var_name, value)
    end
  end
end
