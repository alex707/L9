# module for validation
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # for description class method validate
  module ClassMethods
    def validate(name, type, opt = nil)
      @validates ||= {}
      @validates[name] ||= []
      @validates[name] << [type, opt]
    end

    def validates
      @validates
    end
  end

  # for validations
  module InstanceMethods
    def validate!
      self.class.validates.each do |name, opt|
        opt.each { |t, f| send(t, name, f) }
      end
      true
    end

    def valid?
      validate!
    rescue StandardError
      false
    end

    def presence(var, _value)
      v = instance_variable_get("@#{var}")
      raise 'Value can not to be nil.' if v.nil?
      raise 'Value can not to be blank.' if v.empty?
      true
    end

    def format(var, value)
      v = instance_variable_get("@#{var}")
      raise 'Value has bad format' if v !~ value
      true
    end

    def type(var, value)
      v = instance_variable_get("@#{var}")
      raise 'Value has bad type' unless v.is_a?(value)
      true
    end
  end
end
