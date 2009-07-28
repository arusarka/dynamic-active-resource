module DynamicActiveResource
  module Associations
    class HasMany < Base
      def set_associated_class_attributes(caller)
        associated_class_site = File.join(caller.class.site.to_s, caller.class.collection_name, caller.resource_identifier)
        associated_class.site = associated_class_site
        associated_class.user = caller.class.user
        associated_class.password = caller.class.password
      end

      def resources_for(caller)
        set_associated_class_attributes(caller)
        associated_class.find(:all)
      end
    end
  end
end