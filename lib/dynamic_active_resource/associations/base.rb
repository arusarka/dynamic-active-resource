module DynamicActiveResource
  module Associations
    class Base
      attr_reader :method_name
      def initialize(method_name, options = {})
        @method_name = method_name.to_s
        class_name = options[:through] || @method_name.singularize.camelize
        @associated_class_name = class_name
      end

      # fetches the resources for the association. requires the caller to be
      # passed through self.
      def resources_for(caller)
        raise 'Not Implemented'
      end

      private
      def associated_class
        eval(@associated_class_name)
      end
    end
  end
end