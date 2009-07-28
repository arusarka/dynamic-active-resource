module DynamicActiveResource
  module Associations
    class BelongsTo < Associations::Base
      def resources_for(caller)
        site_elements = caller.class.site.path.split('/')
        associated_resource_id = site_elements[-1]
        associated_class.find(associated_resource_id)
      end
    end
  end
end