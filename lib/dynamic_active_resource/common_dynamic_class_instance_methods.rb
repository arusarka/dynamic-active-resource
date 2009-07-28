module DynamicActiveResource
  module CommonDynamicClassInstanceMethods
    def method_missing(method_symbol, *arguments) #:nodoc:
      method_name = method_symbol.to_s
      # dynamic setters and getters
      case method_name.last
      when "="
        return attributes[method_name.first(-1)] = arguments.first
      when "?"
        return attributes[method_name.first(-1)]
      else
        # return attributes
        return attributes[method_name] if(attributes.has_key?(method_name))
        # return the association if it is a association method
        return get_association(method_name) if(association_method?(method_name))
        super
      end
    end
    
    def resource_identifier
      id()
    end
    
    private
    def association_method?(method_name)
      @associations ||= self.class.instance_variable_get(:@associations)
      return false unless @associations
      association = @associations.detect { |association| association.method_name.to_s == method_name.to_s }
      association ? true : false
    end
    
    def get_association(method_name)
      @associations ||= self.class.instance_variable_get(:@associations)
      association = @associations.detect { |association| association.method_name.to_s == method_name.to_s }
      association.resources_for(self)
    end
  end
end