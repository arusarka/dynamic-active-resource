require 'dynamic_active_resource/associations/base'
require 'dynamic_active_resource/associations/has_many'
require 'dynamic_active_resource/associations/belongs_to'

module DynamicActiveResource
  module Associations
    def has_many(assosiation_sym, options = {})
      h_m_association = HasMany.new(assosiation_sym, options)
      associations = self.instance_variable_get(:@associations) || []
      associations << h_m_association
      self.instance_variable_set(:@associations, associations)
    end
    
    def belongs_to(association_sym, options = {})
      b_t_association = BelongsTo.new(association_sym, options)
      associations = self.instance_variable_get(:@associations) || []
      associations << b_t_association
      self.instance_variable_set(:@associations, associations)
    end
  end
end