module DynamicActiveResource
  module Version
    Major = '0'
    Minor = '2'
    Tiny  = '5'
    
    def self.to_s
      [Major, Minor, Tiny].join('.')
    end
  end
end