module DynamicActiveResource
  module Version
    Major = '0'
    Minor = '0'
    Tiny  = '2'
    
    def self.to_s
      [Major, Minor, Tiny].join('.')
    end
  end
end