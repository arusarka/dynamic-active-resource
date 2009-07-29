module DynamicActiveResource
  module Version
    Major = '0'
    Minor = '1'
    Tiny  = '9'
    
    def self.to_s
      [Major, Minor, Tiny].join('.')
    end
  end
end